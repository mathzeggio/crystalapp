#!/bin/bash

crystal sam.cr db:migrate
crystal run src/app.cr
