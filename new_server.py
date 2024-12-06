#!/usr/bin/env python3

import sys
import logging
from pygls.server import LanguageServer

# Configura il logging per il debug
logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)
logger = logging.getLogger(__name__)

# Definisci la classe per il server LSP


class SuperColliderLanguageServer(LanguageServer):
    def __init__(self):
        super().__init__('supercollider_lsp', 'v0.1')


server = SuperColliderLanguageServer()

if __name__ == "__main__":
    logger.debug("Avvio del SuperCollider LSP...")
    server.start_io()  # Inizializza il server LSP
    logger.debug("SuperCollider LSP terminato.")
