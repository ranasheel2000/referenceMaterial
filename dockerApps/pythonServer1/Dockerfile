FROM python:alpine3.7
COPY . /pythonServer1
WORKDIR /pythonServer1
RUN pip install -r requirements.txt
EXPOSE 5001
CMD python ./index.py
