import openai
openai.api_key = os.environ.get("OPENAI_API_SECRET_KEY")

response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[{"role":"system","content":"You are a professional assistant."},
              {"role":"user", "content":"describe this startup. @record.url"}]
)
print(response["choices"][0]["message"]["content"])