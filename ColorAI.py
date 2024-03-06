import cv2
import numpy as np
from PIL import Image, ImageTk
from sklearn.cluster import KMeans
from collections import Counter
import requests
from io import BytesIO
import base64
from removebg import RemoveBg

def ColorChangeAI(phoneNumber, templateURL):
    try:
        def get_image_from_url(image_url):
            response = requests.get(image_url)
            image = Image.open(BytesIO(response.content))
            return image

        def get_most_used_color_excluding_background(image):
            rgb_img = image.convert("RGB")
            img_array = np.array(rgb_img)
            pixels = img_array.reshape((-1, 3))

            kmeans = KMeans(n_clusters=2, n_init=10)
            kmeans.fit(pixels)
            background_color = kmeans.cluster_centers_[np.argmin(np.sum(kmeans.labels_ == 0))]
            mask = np.all(img_array != background_color, axis=-1)
            pixel_data = img_array[mask]
            color_counts = Counter(map(tuple, pixel_data))
            most_used_color = color_counts.most_common(4)[-1]
            color_rgb = most_used_color[0]
            color_name = f"#{color_rgb[0]:02X}{color_rgb[1]:02X}{color_rgb[2]:02X}"

            return color_name, color_rgb

        image_url = templateURL
        img = get_image_from_url(image_url)
        color_name, color_rgb = get_most_used_color_excluding_background(img)
        print(color_name, color_rgb)

        list_representation = list(color_rgb)
        reversed_list = list_representation[::-1]
        color_rgb1 = tuple(reversed_list)

        class ClothColorChanger:
            def __init__(self, image_path, default_color=color_rgb1):
                self.image_path = image_path
                self.image = cv2.imread(image_path)
                self.original_image = self.image.copy()
                self.detected_cloth = None
                self.selected_color = np.uint8(default_color)

                self.detect_and_change_cloth()
                self.uploaded_url = self.save_modified_image()

            def save_modified_image(self):
                modified_image_path = "modified_images/{}.jpg".format(phoneNumber)
                cv2.imwrite(modified_image_path, self.image)
                self.remove_background(modified_image_path)

                api_key = '9ed666bcae79116dea7d068c2aaa3163'

                with open("modified_images/{}.png".format(phoneNumber), 'rb') as file:
                    image_data = base64.b64encode(file.read()).decode('utf-8')

                endpoint = 'https://api.imgbb.com/1/upload'
                payload = {
                    'key': api_key,
                    'image': image_data
                }
                response = requests.post(endpoint, data=payload)
                result = response.json()

                if 'data' in result and 'url' in result['data']:
                    image_url = result['data']['url']
                    return image_url

            def remove_background(self, image_path):
                RemoveBg(image_path, "modified_images/{}.png".format(phoneNumber))

            def detect_and_change_cloth(self, opacity=0.5):
                hsv_image = cv2.cvtColor(self.original_image, cv2.COLOR_BGR2HSV)
                lower_white = np.array([0, 0, 200], dtype=np.uint8)
                upper_white = np.array([180, 30, 255], dtype=np.uint8)
                mask = cv2.inRange(hsv_image, lower_white, upper_white)
                contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
                contours = sorted(contours, key=cv2.contourArea, reverse=True)
                if contours:
                    largest_contour = contours[0]
                    self.detected_cloth = np.zeros_like(self.original_image[:, :, 0], dtype=np.uint8)
                    cv2.drawContours(self.detected_cloth, [largest_contour], -1, 255, thickness=cv2.FILLED)
                    roi = cv2.bitwise_and(self.original_image, self.original_image, mask=self.detected_cloth)
                    lab_roi = cv2.cvtColor(roi, cv2.COLOR_BGR2LAB)
                    l_channel = lab_roi[:, :, 0]
                    _, quantized_l_channel = cv2.threshold(l_channel, 128, 255, cv2.THRESH_BINARY)
                    quantized_mask = cv2.bitwise_and(self.detected_cloth, quantized_l_channel)
                    modified_image = self.original_image.copy()
                    modified_image[self.detected_cloth != 0] = self.selected_color
                    self.image = cv2.addWeighted(self.original_image, 1 - opacity, modified_image, opacity, 0)

        file_path = "profiles/{}.png".format(phoneNumber)
        if file_path:
            default_color = color_rgb1
        cloth_color_changer = ClothColorChanger(file_path, default_color)

        return cloth_color_changer.uploaded_url, color_rgb1
    except Exception as e:
        print("Error uploading", e)
        return None, None

# uploaded_url, rgb_values = ColorChangeAI("7990187279", "https://i.ibb.co/m6Jm1r2/1480c234fb22.jpg")
# print("Uploaded URL:", uploaded_url)
# print("RGB Values:", rgb_values)
