FROM genotek/r-base
WORKDIR /app
COPY . .
RUN chmod +x /app/script.sh \
    && pip3 install -r requirements.txt

EXPOSE 5000
CMD ["python3", "app.py"]
