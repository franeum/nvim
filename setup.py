from setuptools import setup, find_packages

setup(
    name="my_lsp_plugin",
    version="0.1.0",
    description="A custom LSP plugin for pylsp providing completion support",
    author="Your Name",
    author_email="your.email@example.com",
    license="MIT",
    packages=find_packages(),  # Trova automaticamente il pacchetto 'my_lsp_plugin'
    install_requires=[
        "python-lsp-server",  # Dipendenza necessaria
    ],
    entry_points={
        "pylsp": [
            "my_lsp_plugin = my_lsp_plugin",  # Registra il plugin nel namespace pylsp
        ],
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.6',  # Versione minima di Python
)
