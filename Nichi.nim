import tables
import sequtils

var N:int = 13
var W:int = N + 2
var empty:string = "\n"
let colstr:string = "ABCDEFGHJKLMNOPQRST"
let MAX_GAME_LEN:int = N * N * 3
for nn in 1 .. N + 1:
    empty = empty & " "
for nn in 1 .. N:
    empty = empty & " "
    for no in 1 .. N:
        empty = empty & "."
for nn in 1 .. N + 2:
    empty = empty & " "
var N_SIMS:int = 1400
var RAVE_EQUIV:int = 3500
var EXPAND_VISITS:int = 8
var PRIOR_EVEN:int = 10  # should be even number; 0.5 prior
var PRIOR_SELFATARI:int = 10  # negative prior
var PRIOR_CAPTURE_ONE:int = 15
var PRIOR_CAPTURE_MANY:int = 30
var PRIOR_PAT3:int = 10
var PRIOR_LARGEPATTERN:int = 100  # most moves have relatively small probability
let PRIOR_CFG: seq[int] = @[24, 22, 8]  # priors for moves in cfg dist. 1, 2, 3
var PRIOR_EMPTYAREA:int = 10
var REPORT_PERIOD:int = 200
var PROB_HEURISTIC = to_table({"capture": 0.9, "pat3": 0.95}) # probability of heuristic suggestions being taken in playout
let PROB_SSAREJECT:float = 0.9  # probability of rejecting suggested self-atari in playout
let PROB_RSAREJECT:float = 0.5  # probability of rejecting random self-atari in playout; this is lower than above to allow nakade
let RESIGN_THRES:float = 0.2
let FASTPLAY20_THRES:float = 0.8  # if at 20% playouts winrate is >this, stop reading
let FASTPLAY5_THRES:float = 0.95  # if at 5% playouts winrate is >this, stop reading

proc neighbors(c:int): seq[int] =
    return @[c-1, c+1, c-W, c+W]

proc diag_neighbors(c:int): seq[int] =
    return @[c-W-1, c-W+1, c+W-1, c+W+1]

