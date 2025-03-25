from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

@app.route('/time', methods=['GET'])
def get_time():
    try:
        # Выполняем shell-скрипт
        result = subprocess.run(['/app/script.sh'], capture_output=True, text=True, check=True)
        # Возвращаем результат с HTTP-статусом 200
        return jsonify(status=200, message=result.stdout.strip()), 200
    except subprocess.CalledProcessError as e:
        # В случае ошибки возвращаем HTTP-статус 500
        return jsonify(status=500, message="Error executing script"), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
