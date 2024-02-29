from rembg import remove
from PIL import Image



def remove_bg(input_path, output_path):
    input_image = Image.open(input_path)
    output_image = remove(input_image)
    output_image.save(output_path)


if __name__ == "__main__":
    remove_bg("./posts/treding1.jpg", "./posts/trendig1.png")