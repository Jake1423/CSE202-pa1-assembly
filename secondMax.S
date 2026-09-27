.global secondMax
# v1 in %di, v2 in %si, v3 in %dx, v4 in %cx  (signed 16-bit); result in %ax
secondMax:
  cmpw %si, %di            # compare v1 with v2 (%di - %si)
  jl .Lsm_v2big            # v1 < v2 -> V2BIG
  movw %di, %r8w           # first = v1
  movw %si, %ax            # second = v2
  jmp .Lsm_check3
.Lsm_v2big:
  movw %si, %r8w           # first = v2
  movw %di, %ax            # second = v1
.Lsm_check3:
  cmpw %r8w, %dx           # compare v3 with first (%r8w - %dx)
  jle .Lsm_check3b         # v3 <= first -> CHECK3B
  movw %r8w, %ax           # second = first
  movw %dx, %r8w           # first = v3
  jmp .Lsm_check4
.Lsm_check3b:
  cmpw %ax, %dx            # compare v3 with second (%ax - %dx)
  jle .Lsm_check4          # v3 <= second -> CHECK4
  movw %dx, %ax            # second = v3
.Lsm_check4:
  cmpw %r8w, %cx           # compare v4 with first (%r8w - %cx)
  jle .Lsm_check4b         # v4 <= first -> CHECK4B
  movw %r8w, %ax           # second = first
  movw %cx, %r8w           # first = v4
  jmp .Lsm_done
.Lsm_check4b:
  cmpw %ax, %cx            # compare v4 with second (%ax - %cx)
  jle .Lsm_done            # v4 <= second -> DONE
  movw %cx, %ax            # second = v3 (now v4)
.Lsm_done:
  ret

# short secondMax(short v1, short v2, short v3, short v4){
#     short first, second;
#     if(v1 >= v2){ first = v1; second = v2; }
#     else        { first = v2; second = v1; }
#     if(v3 > first)       { second = first; first = v3; }
#     else if(v3 > second) { second = v3; }
#     if(v4 > first)       { second = first; first = v4; }
#     else if(v4 > second) { second = v4; }
#     return second;
# }
