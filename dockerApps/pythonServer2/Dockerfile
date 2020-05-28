FROM python:alpine3.7
COPY . /pythonServer2
WORKDIR /pythonServer2
RUN pip install -r requirements.txt
EXPOSE 5002
CMD python ./index.py
