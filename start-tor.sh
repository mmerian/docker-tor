#!/usr/bin/env bash

if [ ! -f $TOR_CONFIG_DIR/$TOR_CONFIG_FILE ]; then
    echo "Creating config dir $TOR_CONFIG_DIR"
    mkdir -p $TOR_CONFIG_DIR
    echo "Copying $TOR_ORIGIN_CONFIG_PATH to $TOR_CONFIG_DIR"
    cp $TOR_ORIGIN_CONFIG_PATH $TOR_CONFIG_DIR
fi

su -l $TOR_USER -s /bin/bash -c "$TOR_BIN -f $TOR_CONFIG_DIR/$TOR_CONFIG_FILE"
