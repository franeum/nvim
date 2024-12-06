#!/usr/bin/env python3

import pygls
# from lsprotocol.types import CompletionItem, CompletionParams, Position, TEXT_DOCUMENT_COMPLETION
# from pygls.server import LanguageServer

from pygls.server import LanguageServer
from lsprotocol.types import (
    CompletionItem,
    CompletionItemKind,
    CompletionList,
    CompletionParams,
    InitializeParams,
    TextDocumentSyncKind,
    TEXT_DOCUMENT_COMPLETION,
    InlineCompletionItem
)
# from pygls.features import COMPLETION

# Crea il Language Server


class SuperColliderLanguageServer(LanguageServer):
    def __init__(self):
        super().__init__("supercollider-ls", "v0.1")


server = SuperColliderLanguageServer()

# Configura l'inizializzazione


@server.feature("initialize")
def initialize(params: InitializeParams):
    return {
        "capabilities": {
            "textDocumentSync": TextDocumentSyncKind.Full,
            "completionProvider": {"resolveProvider": False},
        }
    }


# Implementa il completamento
@server.feature(TEXT_DOCUMENT_COMPLETION)
def completions(params: CompletionParams):
    # Esempio di completamenti per SuperCollider
    print("CHIAMATA")
    completions = [
        CompletionItem("SinOsc", kind=CompletionItemKind.Class,
                       detail="Sine wave oscillator"),
        CompletionItem("play", kind=CompletionItemKind.Method,
                       detail="Play the current SynthDef"),
        CompletionItem(
            "Server.default", kind=CompletionItemKind.Property, detail="Default server"),
        CompletionItem(
            "boot", kind=CompletionItemKind.Property, detail="Default server")
    ]

    return CompletionList(is_incomplete=False, items=completions)


# Avvia il server
if __name__ == "__main__":
    server.start_io()

# server.start_tcp('127.0.0.1', 8080)
