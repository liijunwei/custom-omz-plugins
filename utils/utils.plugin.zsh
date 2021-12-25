# decimal to binary
function toBinary() {
  local decimal=$1;
  echo "obase=2 ; $decimal" | bc
}

# binary to decimal
function toDecimal() {
  local binary=$1;
  echo $((2#$binary))
}
