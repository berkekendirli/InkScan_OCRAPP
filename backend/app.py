from flask import Flask, request, jsonify
from flask_cors import CORS
import pytesseract
import cv2
import numpy as np
import io

app = Flask(__name__)
CORS(app)

pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

@app.route('/process-image', methods=['POST'])
def process_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    image_file = request.files['image']
    language = request.form.get('language', 'eng')

    try:
        image_stream = image_file.read()
        npimg = np.frombuffer(image_stream, np.uint8)
        img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

        # Gri ton + eşikleme
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        thresh = cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)[1]
        resized = cv2.resize(thresh, None, fx=1.5, fy=1.5, interpolation=cv2.INTER_LINEAR)

        text = pytesseract.image_to_string(resized, lang=language).strip()

        # Kısa metinse tekrar dene (PSM 7 - tek satır)
        if len(text) < 10:
            config_line = '--oem 3 --psm 7'
            text = pytesseract.image_to_string(resized, lang=language, config=config_line).strip()

        return jsonify({'text': text})
    
    except Exception as e:
        return jsonify({'error': 'OCR failed', 'details': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
