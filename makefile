


MODEL = Llama-2-7b-chat-hf
PORT = 8080

download:
	# git clone https://huggingface.co/meta-llama/Llama-2-7b-chat-hf models
	# git clone https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.1 models
	# git clone https://huggingface.co/TheBloke/Llama-2-7B-AWQ models
	git clone https://huggingface.co/4bit/Llama-2-7b-chat-hf models


run-fastapi:
	python -m vllm.entrypoints.api_server \
	--model $(MODEL) --port $(PORT)

run-openai:
	python -m vllm.entrypoints.openai.api_server \
	--model $(MODEL) --port $(PORT)

run:
	python app.py --model models \
	--dtype half 