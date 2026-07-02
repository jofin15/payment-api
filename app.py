from flask import Flask, jsonify, request
import uuid
import datetime

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health():
    return jsonify({
        "status": "healthy",
        "timestamp": str(datetime.datetime.now())
    })

@app.route('/api/payments', methods=['GET'])
def get_payments():
    return jsonify({
        "payments": [],
        "total": 0
    })

@app.route('/api/payments', methods=['POST'])
def create_payment():
    data = request.get_json()
    payment = {
        "id": str(uuid.uuid4()),
        "amount": data.get("amount"),
        "currency": data.get("currency", "USD"),
        "status": "pending",
        "created_at": str(datetime.datetime.now())
    }
    return jsonify(payment), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
