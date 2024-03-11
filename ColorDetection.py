import cv2
import numpy as np
from sklearn.cluster import MiniBatchKMeans

def calculate_contrast_ratio(color1, color2):
    # Function to calculate the contrast ratio between two colors
    luminance1 = 0.2126 * color1[0] / 255 + 0.7152 * color1[1] / 255 + 0.0722 * color1[2] / 255
    luminance2 = 0.2126 * color2[0] / 255 + 0.7152 * color2[1] / 255 + 0.0722 * color2[2] / 255
    brighter = max(luminance1, luminance2)
    darker = min(luminance1, luminance2)
    contrast_ratio = (brighter + 0.05) / (darker + 0.05)  # Adding a small value to avoid division by zero
    return contrast_ratio

def get_best_text_color(background_color):
    # Function to determine the best text color based on the background color
    black_contrast = calculate_contrast_ratio(background_color, [0, 0, 0])
    white_contrast = calculate_contrast_ratio(background_color, [255, 255, 255])
    
    return [0, 0, 0] if black_contrast > white_contrast else [255, 255, 255]

def display_with_text(image, dominant_color, text_color):
    # Function to display the dominant color with sample text using the specified text color
    cv2.imshow(f'Dominant Color', cv2.cvtColor(image, cv2.COLOR_RGB2BGR))
    
    # Create an image for text display
    text_image = np.ones_like(image) * 255  # White background
    cv2.putText(text_image, 'Sample Text', (50, 50), cv2.FONT_HERSHEY_SIMPLEX, 1, text_color, 2, cv2.LINE_AA)
    
    # Convert text image to the same data type as the input image
    text_image = text_image.astype(image.dtype)
    
    # Display the image with sample text
    cv2.imshow(f'Text Color', cv2.cvtColor(text_image, cv2.COLOR_RGB2BGR))
    cv2.waitKey(0)

def detect_all_colors(image_path, num_colors=5, exclude_black=True):
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

    # If black should be excluded, check if it's among the dominant colors
    if exclude_black and any(np.all(color == [0, 0, 0]) for color in dominant_colors):
        # If black is present, find the nearest non-black color and replace it
        for i in range(num_colors):
            if np.all(dominant_colors[i] == [0, 0, 0]):
                # Replace black with the nearest non-black color
                non_black_color = np.delete(dominant_colors, i, axis=0)
                replacement_color = non_black_color[np.argmin(np.linalg.norm(non_black_color - [0, 0, 0], axis=1))]
                dominant_colors[i] = replacement_color

    # Display or save the result
    for i in range(num_colors):
        dominant_color_image = np.zeros_like(image_rgb)
        dominant_color_image[:, :] = dominant_colors[i]

        # Determine the best text color based on the background color
        # text_color = get_best_text_color(dominant_colors[i])

        # Display the dominant color with the best text color and sample text
        # display_with_text(dominant_color_image, dominant_colors[i], text_color)

    # Print the RGB codes of the dominant colors, excluding black if specified
    final_dominant_colors = [tuple(color.tolist()) for color in dominant_colors]
    final_text_colors = [get_best_text_color(color) for color in final_dominant_colors]

    return final_dominant_colors, final_text_colors


# Example usage
input_image_path = r"profiles\7990187279.png"
RGBValues, TextValues = detect_all_colors(input_image_path, num_colors=5) # Set num_colors based on the desired number of dominant colors
print("Dominant Colors:", RGBValues)
print("Text Colors:", TextValues)