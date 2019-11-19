#!/bin/bash

iverilog Ejer2.v Ejer2_tb.v -o test
vvp test
rm -f test