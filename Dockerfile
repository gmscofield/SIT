FROM python:3.10

WORKDIR /app

COPY . /app
RUN pip install --no-cache-dir -r /app/scancode_toolkit/requirements.txt
RUN pip install --no-cache-dir -r /app/SIT/requirements.txt

EXPOSE 9020

# CMD ["cd", "/app/server", "python", "./server.py"]
WORKDIR /app/
# CMD ["fastapi", "run", "./server.py", "--host", "127.0.0.1", "--port", "9002"]
# CMD ["uvicorn", "run", "./server.py", "--host", "127.0.0.1", "--port", "9002"]
ENTRYPOINT ["python", "-m", "SIT"]