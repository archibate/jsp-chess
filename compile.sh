#!/bin/bash
set -e

cd AI
cmake -B build
cmake --build build
cd ..
staticx --strip AI/build/ChessAI ChessAI
