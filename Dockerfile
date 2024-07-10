FROM python:3.9-slim
WORKDIR /app
COPY app.py .
RUN pip install tzdata
EXPOSE 3030
CMD ["python", "app.py"]

