#!/bin/sh
rm -rf /deployed/*
cd /deployed && git clone --branch=main /www .
rm -rf /delpoyed/.git