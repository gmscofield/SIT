FROM python:3.10

# Install dependencies
WORKDIR /app/
RUN pip install poetry
RUN poetry config virtualenvs.create false
COPY pyproject.toml poetry.lock /app/
RUN poetry install --no-dev

# Copy the source code
COPY SIT /app/SIT
EXPOSE 9020
ENTRYPOINT ["python", "-m", "SIT"]
CMD [ "--server" ]