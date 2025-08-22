import os
from PIL import Image

IMAGE_WIDTH = 600
IMAGE_HEIGHT = 300
LOGO_FILE = 'java_logo.png'

logo = Image.open(LOGO_FILE)

os.makedirs('변경된 파일', exist_ok=True)

for fname in os.listdir('.'):
    if fname == LOGO_FILE:
        continue 
    if fname.endswith('.png') or fname.endswith('.jpg') :
        image = Image.open(fname)
        image = image.resize((IMAGE_WIDTH, IMAGE_HEIGHT))
        image.paste(logo, (0, 0), logo)
        image.save(os.path.join('변경된 파일', fname))

print("변경 작업을 마쳤습니다.")