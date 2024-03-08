import cv2
import numpy as np
from sklearn.cluster import MiniBatchKMeans

def detect_all_colors(image_path, num_colors=5):
    # Read the image
    image = cv2.imread(image_path)
    image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    # Reshape the image to a list of pixels
    pixels = image_rgb.reshape((-1, 3))

    # Convert to float32 for MiniBatchKMeans clustering
    pixels = np.float32(pixels)

    # Perform MiniBatchKMeans clustering
    kmeans = MiniBatchKMeans(n_clusters=num_colors)
    kmeans.fit(pixels)

    # Get the dominant colors
    dominant_colors = kmeans.cluster_centers_.astype(np.uint8)

    # Display or save the result
    for i in range(num_colors):
        dominant_color_image = np.zeros_like(image_rgb)
        dominant_color_image[:, :] = dominant_colors[i]
        cv2.imshow(f'Dominant Color {i+1}', cv2.cvtColor(dominant_color_image, cv2.COLOR_RGB2BGR))
        cv2.waitKey(0)

    # Print the RGB codes of the dominant colors
    print("Dominant Colors (RGB):", [tuple(color) for color in dominant_colors])

# Example usage
input_image_path = r"profiles\7990187279.png"
detect_all_colors(input_image_path, num_colors=3)

# import cv2
# import numpy as np

# def most_used_color(image_path):
#     # Read the image with an alpha channel (transparency)
#     image = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)

#     # Extract the RGB channels
#     image_rgb = image[:, :, :3]

#     # Create a mask to exclude transparent pixels
#     alpha_channel = image[:, :, 3]
#     non_transparent_pixels = (alpha_channel > 0)

#     # Apply the mask to the RGB image
#     image_rgb = image_rgb[non_transparent_pixels]

#     # Convert the RGB image to a list of pixels
#     pixels = image_rgb.reshape((-1, 3))

#     # Calculate histogram for the entire image
#     hist = cv2.calcHist([pixels], [0, 1, 2], None, [256, 256, 256], [0, 256, 0, 256, 0, 256])

#     # Find the index of the peak in each channel
#     peak_index = np.unravel_index(np.argmax(hist, axis=None), hist.shape)

#     # Get the most used color
#     most_used_color = [peak_index[0], peak_index[1], peak_index[2]]

#     # Display or save the result
#     most_used_color_image = np.zeros((1, 1, 3), dtype=np.uint8)
#     most_used_color_image[0, 0] = most_used_color
#     cv2.imshow('Most Used Color', most_used_color_image)
#     cv2.waitKey(0)

#     # Print the RGB code of the most used color
#     print("Most Used Color (RGB):", tuple(most_used_color))

# # Example usage
# input_image_path = "testing.png"
# most_used_color(input_image_path)


