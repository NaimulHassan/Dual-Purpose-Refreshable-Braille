import cv2
from PIL import Image
import pytesseract
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract'
image = Image.open('IMG.jpg')
#image = cv2.imread('Capture_jukto.jpg')
#image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
#(thresh, blackAndWhiteImage) = cv2.threshold(image, 127, 255, cv2.THRESH_BINARY)
#image=~blackAndWhiteImage

#cv2.imshow('Original image',image)
str_bang=(pytesseract.image_to_string(image, lang='ben'))
print(str_bang)
#print(str_bang(2))
#cv2.waitKey(0)ben
#cv2.destroyAllWindows()

