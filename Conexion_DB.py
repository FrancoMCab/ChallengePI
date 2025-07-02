from dotenv import load_dotenv
import os
import pyodbc

load_dotenv()

class ConexionDB:
    def __init__(self):
        self.server = os.getenv("SQL_SERVER")
        self.db = os.getenv("SQL_DATABASE")
        self.user = os.getenv("SQL_USER")
        self.password = os.getenv("SQL_PASSWORD")
        self.conn = None

    def conectar(self):
        try:
            self.conn = pyodbc.connect(
                f'DRIVER={{ODBC Driver 17 for SQL Server}};'
                f'SERVER={self.server};'
                f'DATABASE={self.db};'
                f'UID={self.user};'
                f'PWD={self.password}'
            )
            print("Conexion exitosa")
            return self.conn
    
        except pyodbc.Error as e:
            print("Error al conectar a la base de datos:", e)
            return None

    def cerrar(self):
        if self.conn:
            self.conn.close()