from flask import Flask, request, jsonify
from flask_cors import CORS
import pytesseract
from PIL import Image
import io

app = Flask(__name__)
CORS(app) 

pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

@app.route('/process-image', methods=['POST'])
def process_image():
    if 'image' not in request.files:
        print("No image found in the request.")  # Gelen istekte 'image' yok
        return jsonify({'error': 'No image uploaded'}), 400

    image_file = request.files['image']
    language = request.form.get('language', 'eng')
    print(f"Received file: {image_file.filename}")  # Gelen dosyanın adını yazdır

    try:
        image = Image.open(io.BytesIO(image_file.read()))
        text = pytesseract.image_to_string(image, lang=language)
        print(f"OCR Result: {text}")  # OCR sonucunu yazdır
        return jsonify({'text': text})
    except Exception as e:
        print(f"Error during OCR: {e}")  # Hata durumunda hata mesajını yazdır
        return jsonify({'error': 'OCR failed', 'details': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)