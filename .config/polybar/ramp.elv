val = $args[0]
if (< $val 12) {
  echo "%{F#aaff77}▁"
} elif (< $val 25) {
  echo "%{F#aaff77}▂"
} elif (< $val 37) {
  echo "%{F#aaff77}▃"
} elif (< $val 40) {
  echo "%{F#aaff77}▄"
} elif (< $val 52) {
  echo "%{F#fba922}▅"
} elif (< $val 75) {
  echo "%{F#fba922}▆"
} elif (< $val 87) {
  echo "%{F#ff5555}▇"
} else {
  echo "%{F#ff5555}█"
}
