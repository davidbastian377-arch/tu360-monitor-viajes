install:
	pip install -r requirements.txt
	pip install -e .

db:
	docker compose up -d

init:
	python scripts/inicializar_bd.py

demo:
	python scripts/cargar_demo.py

dashboard:
	streamlit run dashboard/app.py
