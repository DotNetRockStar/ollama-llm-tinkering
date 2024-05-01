# TL;DR

Run the app:
```
% pip install BeautifulSoup4 langchain langchain-community langchain-core tikToken chromadb
% ollama pull nomic-embed-text
% ollama pull mistral
% python app/app.py
```

## What Does it Do?
We want to demonstrate how to ask the Llama LLM a question, demonstrate how to fetch data about the question, feed data as context in to follow up question, then receive different (better) answer.

1. Ask llama: W`hat is Ollama?  Receive response X.`
2. Pull text from 3 web pages, create embeddings from model, and store in Chroma vector db: https://ollama.com, https://ollama.com/blog/windows-preview, https://ollama.com/blog/openai-compatibility 
3. Re-Ask llama the same question but add context data from step 2: `What is Ollama?  Receive response Y.`

# Overview
This project is a playground for tinkering with llama3 genai.

## Technologies
- llama3
- ollama (https://github.com/ollama/ollama)

