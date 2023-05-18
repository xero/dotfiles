#!/bin/sh
echo

# mini smpte color bars
for y in $(seq 0 6); do
  printf %s '      '
  for color in 7 3 6 2 5 1 4; do
    tput setab ${color}
    printf %s '    '
  done
  tput sgr0
  echo
done

for y in 0 1; do
  printf %s '      '
  for color in 4 0 5 0 6 0 7; do
    tput setab ${color}
    printf %s '    '
  done
  tput sgr0
  echo
done

for y in $(seq 0 2); do
  printf %s '      '
  for color in 4 4 4 4 4 7 7 7 7 7 5 5 5 5 5 0 0 0 0 0 0 0 0 0 0 0 0 0; do
    tput setab ${color}
    printf %s ' '
  done
  tput sgr0
  echo
done

echo
