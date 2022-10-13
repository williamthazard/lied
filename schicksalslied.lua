---schicksalslied

engine.name = 'LiedMotor'
LiedMotor = include('lib/LiedMotor_engine')
MusicUtil = require "musicutil"
sequins = require "sequins"
fileselect = require 'fileselect'
sh = hid.connect(1)
if sh.device then
    shnth = include("shnth/lib/shnth")
    sh.event = shnth.event
    else shnth = {}
end

selectedfile = _path.dust.."audio/hermit_leaves.wav"

local my_string = " "
history = {}
local history_index = nil
local new_line = false

running = false 
going = false
walking = false

starter = 1
firstrate = 1
secondrate = 1
thirdrate = 1

function softcut_init()
  softcut.buffer_clear()
  for i=1,6 do
    softcut.enable(i,1)
    softcut.level(i,1.0)
    softcut.buffer(i,i%2+1)
    softcut.position(i,1)
    softcut.play(i,0)
    softcut.level_slew_time(i,1.0)
    softcut.phase_quant(i,0.5)
    softcut.loop(i,1)
  end
  softcut.voice_sync(2,1,0)
  softcut.voice_sync(4,3,0)
  softcut.voice_sync(6,5,0)
  softcut.pan(1,-1)
  softcut.pan(2,1)
  softcut.pan(3,-1)
  softcut.pan(4,1)
  softcut.pan(5,-1)
  softcut.pan(6,1)
  softcut.event_phase(update_positions)
  softcut.poll_start_phase()
end

function Split()
  for line in io.lines() do
    if #line > 0 then
    table.insert(history, line)
    end
  end
end

function step()
    while true do
        clock.sync(s:step(2)()/s:step(3)())
        if running then
            local note_num = s()
            local freq = MusicUtil.note_num_to_freq(note_num)
            LiedMotor.trig(freq)
        end
    end
end

function steptwo()
    while true do
        clock.sync(s:step(4)()/s:step(5)())
        if running then
            local note_num = s:step(6)()
            local freq = MusicUtil.note_num_to_freq(note_num)
            LiedMotor.trigtwo(freq)
        end
    end
end

function stepthree()
    while true do
        clock.sync(s:step(7)()/s:step(8)())
        if running then
            local note_num = s:step(9)()
            local freq = MusicUtil.note_num_to_freq(note_num)
            LiedMotor.trigthree(freq)
        end
    end
end

function stepfour()
    while true do
        clock.sync(s:step(10)()/s:step(11)())
        if running then
            local note_num = s:step(12)()
            local freq = MusicUtil.note_num_to_freq(note_num)
            LiedMotor.trigfour(freq)
        end
    end
end

function stepfive()
    while true do
        clock.sync(s:step(13)()/s:step(14)())
        if running then
            local note_num = s:step(15)()
            local freq = MusicUtil.note_num_to_freq(note_num)
            LiedMotor.trigfive(freq)
        end
    end
end

function stepsix()
    while true do
        clock.sync(s:step(16)()/s:step(17)())
        if running then
            local note_num = s:step(18)()
            local freq = MusicUtil.note_num_to_freq(note_num)
            LiedMotor.trigsix(freq)
        end
    end
end

function update_positions(i,pos)
  my_positions[i] = pos - 1
end

my_positions = {}

function softone()
  while true do
    clock.sync(s:step(19)()/s:step(20)())
    if going then
      local firstfade = 1/j:step(21)()
      softcut.fade_time(1,firstfade)
      softcut.fade_time(2,firstfade)
      local ch,length,rate = audio.file_info(selectedfile)
      if length/rate > 300 then length = 300
        else length = length/rate
      end
      local firstposition = util.linlin(49,80,0,length-0.5,s:step(22)())
      softcut.position(1,firstposition)
      softcut.position(2,firstposition)
      local firstend = util.linlin(49,80,0,length,s:step(23)())
      local realend = firstposition + firstend
      if realend > length then realend = length
        else realend = realend
      end
      softcut.loop_start(1,firstposition)
      softcut.loop_end(1,realend)
      softcut.loop_start(2,firstposition)
      softcut.loop_end(2,realend)
      softcut.loop(1,1)
      softcut.loop(2,1)
    end
  end
end

function softfirstrate()
  while true do
    clock.sync(s:step(24)()/s:step(25)())
    if going then
      local firstrateslew = 1/c:step(26)()
      softcut.rate_slew_time(1,firstrateslew)
      softcut.rate_slew_time(2,firstrateslew)
      firstrate = (s:step(27)()/s:step(28)())
      if firstrate > 16 then firstrate = 16
        else firstrate = firstrate
      end
      if c:step(29)() > 17 then firstrate = firstrate * -1
        else firstrate = firstrate
      end
      softcut.rate(1,firstrate)
      softcut.rate(2,firstrate)
    end
  end
end

function firstpan()
  while true do
    clock.sync(s:step(30)()/s:step(31)())
    if going then
      local firstpan = util.linlin(49,80,-1,1,s:step(32)())
      local firstnegativepan = firstpan * -1
      local firstpanslew = 1/j:step(33)()
      softcut.pan(1,firstpan)
      softcut.pan(2,firstnegativepan)
      softcut.pan_slew_time(1,firstpanslew)
      softcut.pan_slew_time(2,firstpanslew)
    end
  end
end

function softtwo()
  while true do
    clock.sync(s:step(34)()/s:step(35)())
    if going then
      local secondfade = 1/j:step(36)()
      softcut.fade_time(3,secondfade)
      softcut.fade_time(4,secondfade)
      local ch,length,rate = audio.file_info(selectedfile)
      if length/rate > 300 then length = 300
        else length = length/rate
      end
      local secondposition = util.linlin(49,80,0,length-0.5,s:step(37)())
      softcut.position(3,secondposition)
      softcut.position(4,secondposition)
      local secondend = util.linlin(49,80,0,length,s:step(38)())
      local realend = secondposition + secondend
      if realend > length then realend = length
        else realend = realend
      end
      softcut.loop_start(3,secondposition)
      softcut.loop_end(3,realend)
      softcut.loop_start(4,secondposition)
      softcut.loop_end(4,realend)
    end
  end
end

function softsecondrate()
  while true do
    clock.sync(s:step(39)()/s:step(40)())
    if going then
      local secondrateslew = 1/c:step(41)()
      softcut.rate_slew_time(3,secondrateslew)
      softcut.rate_slew_time(4,secondrateslew)
      secondrate = (s:step(42)()/s:step(43)())
      if secondrate > 16 then secondrate = 16
        else secondrate = secondrate
      end
      if c:step(44)() > 17 then secondrate = secondrate * -1
        else secondrate = secondrate
      end
      softcut.rate(3,secondrate)
      softcut.rate(4,secondrate)
    end
  end
end

function secondpan()
  while true do
    clock.sync(s:step(45)()/s:step(46)())
    if going then
      local secondpan = util.linlin(49,80,-1,1,s:step(47)())
      local secondnegativepan = secondpan * -1
      local secondpanslew = 1/j:step(48)()
      softcut.pan(3,secondpan)
      softcut.pan(4,secondnegativepan)
      softcut.pan_slew_time(3,secondpanslew)
      softcut.pan_slew_time(4,secondpanslew)
    end
  end
end

function softthree()
  while true do
    clock.sync(s:step(49)()/s:step(50)())
    if going then
      local thirdfade = 1/j:step(51)()
      softcut.fade_time(5,thirdfade)
      softcut.fade_time(6,thirdfade)
      local ch,length,rate = audio.file_info(selectedfile)
      if length/rate > 300 then length = 300
        else length = length/rate
      end
      local thirdposition = util.linlin(49,80,0,length-0.5,s:step(52)())
      softcut.position(5,thirdposition)
      softcut.position(6,thirdposition)
      local thirdend = util.linlin(49,80,0,length,s:step(53)())
      local realend = thirdposition + thirdend
      if realend > length then realend = length
        else realend = realend
      end
      softcut.loop_start(5,thirdposition)
      softcut.loop_end(5,realend)
      softcut.loop_start(6,thirdposition)
      softcut.loop_end(6,realend)
    end
  end
end

function softthirdrate()
  while true do
    clock.sync(s:step(54)()/s:step(55)())
    if going then
      local thirdrateslew = 1/c:step(56)()
      softcut.rate_slew_time(5,thirdrateslew)
      softcut.rate_slew_time(6,thirdrateslew)
      thirdrate = (s:step(57)()/s:step(58)())
      if thirdrate > 16 then thirdrate = 16
        else thirdrate = thirdrate
      end
      if c:step(59)() > 17 then thirdrate = thirdrate * -1
        else thirdrate = thirdrate
      end
      softcut.rate(5,thirdrate)
      softcut.rate(6,thirdrate)
    end
  end
end

function thirdpan()
  while true do
    clock.sync(s:step(60)()/s:step(61)())
    if going then
      local thirdpan = util.linlin(49,80,-1,1,s:step(62)())
      local thirdnegativepan = thirdpan * -1
      local thirdpanslew = 1/j:step(63)()
      softcut.pan(5,thirdpan)
      softcut.pan(6,thirdnegativepan)
      softcut.pan_slew_time(5,thirdpanslew)
      softcut.pan_slew_time(6,thirdpanslew)
    end
  end
end

function key(n,z)
  if n==2 and z==1 then
    -- K2 toggles softcut
    going = not going
    if going then
      print('going')
      for i=1,6 do
        softcut.play(i,1)
      end
    elseif not going then
      print('not going')
      for i=1,6 do
        softcut.play(i,0)
      end
    end
  elseif n==3 and z==1 then
    -- K3 toggles synth engine
    running = not running
    if running then
    print('running')
    else print('not running')
    end
  elseif n==1 and z==1 then
    -- K1 + K3 toggles crow
    walking = not walking
    if walking then
      print('walking')
        else print('not walking')
    end
  end
end

function init()
  LiedMotor.add_params() -- adds params via the `.add params()` function defined in LiedMotor_engine.lua
  params:add_separator('load files','load files')
  params:add_file('audio file','audio file')
  params:set_action('audio file', function(file) selectedfile=file end)
  params:add_file('text file','text file')
  params:set_action('text file',function(file) io.input(file) Split(file) grid_redraw() end)
  params:add_separator('softcut','softcut')
  params:add_control('softcut_1','softcut_1',controlspec.new(0,1,'lin',0.01,1,''))
  params:set_action('softcut_1',function(x) softcut.level(1,x) softcut.level(2,x) end)
  params:add_control('softcut_2','softcut_2',controlspec.new(0,1,'lin',0.01,1,''))
  params:set_action('softcut_2',function(x) softcut.level(3,x) softcut.level(4,x) end)
  params:add_control('softcut_3','softcut_3',controlspec.new(0,1,'lin',0.01,1,''))
  params:set_action('softcut_3',function(x) softcut.level(5,x) softcut.level(6,x) end)
  params:add_separator('w/syn','w/syn')
  params:add_control('w/syn lpg speed','w/syn lpg speed',controlspec.new(-5,5,'lin',0.01,-3,''))
  params:set_action('w/syn lpg speed',function(x) crow.ii.wsyn.lpg_time(x) end)
  params:add_control('w/syn lpg symmetry','w/syn lpg symmetry',controlspec.new(-5,5,'lin',0.01,-1,''))
  params:set_action('w/syn lpg symmetry',function(x) crow.ii.wsyn.lpg_symmetry(x) end)
  params:add_control('w/syn fm num','w/syn fm num',controlspec.new(-5,5,'lin',0.01,1,''))
  params:set_action('w/syn fm num',function(x) crow.ii.wsyn.fm_ratio(x,params:get('w/syn fm deno')) end)
  params:add_control('w/syn fm deno','w/syn fm deno',controlspec.new(-5,5,'lin',0.01,1,''))
  params:set_action('w/syn fm deno',function(x) crow.ii.wsyn.fm_ratio(params:get('w/syn fm num'),x) end)
  params:add_control('w/syn fm index','w/syn fm index',controlspec.new(-5,5,'lin',0.01,0.1,''))
  params:set_action('w/syn fm index',function(x) crow.ii.wsyn.fm_index(x) end)
  params:add_control('w/syn fm envelope','w/syn fm envelope',controlspec.new(-5,5,'lin',0.01,-0.1,''))
  params:set_action('w/syn fm envelope',function(x) crow.ii.wsyn.fm_env(x) end)
  screen.aa(0)
  grid_dirty = false
  momentary = {}
  for x = 1,16 do -- for each x-column (16 on a 128-sized grid)...
    momentary[x] = {} -- create a table that holds...
    for y = 1,8 do -- each y-row (8 on a 128-sized grid)!
      momentary[x][y] = false -- the state of each key is 'off'
    end
  end
  print("schicksalslied")
  softcut_init()
  bpm = clock.get_tempo()
  clock.run(step)
  clock.run(steptwo)
  clock.run(stepthree)
  clock.run(stepfour)
  clock.run(stepfive)
  clock.run(stepsix)
  clock.run(softone)
  clock.run(softtwo)
  clock.run(softthree)
  clock.run(softfirstrate)
  clock.run(softsecondrate)
  clock.run(softthirdrate)
  clock.run(firstpan)
  clock.run(secondpan)
  clock.run(thirdpan)
  clock.run(notes_event)
  clock.run(other_event)
  clock.run(jfa_event)
  clock.run(jfb_event)
  clock.run(jfc_event)
  clock.run(jfd_event)
  clock.run(jfe_event)
  clock.run(jff_event)
  clock.run(run_event)
  clock.run(quantize_event)
  clock.run(with_event)
  clock.run(rev_event)
  clock.run(looper)
  clock.run(withsyna_event)
  clock.run(withsynb_event)
  clock.run(withsync_event)
  clock.run(withsynd_event)
  clock.run(wcheck)
  clock.run(grid_redraw_clock)
  crow.input[1].mode('clock')
  crow.ii.jf.mode(1)
  crow.ii.jf.run_mode(1)
  crow.ii.jf.tick(bpm)
  crow.ii.wtape.timestamp(1)
  crow.ii.wtape.freq(0)
  crow.ii.wtape.play(0)
  crow.ii.wsyn.ar_mode(1)
  crow.ii.wsyn.voices(4) 
  crow.ii.wsyn.patch(1,1)
  crow.ii.wsyn.patch(2,2)
end

function shnth.bar(n, d)
  params:set('LiedMotor_index7',d)
  if d > 0.2 then
    for i=1,4 do
      if n==i then
        local note_num = s[i]
        local freq = MusicUtil.note_num_to_freq(note_num)
        LiedMotor.trigseven(freq)
      end
    end
  end
end

function shnth.major(n, z)
  if z==1 then
    for i=1,4 do
      if n==i then
        local note_num = s[i+4]
        local freq = MusicUtil.note_num_to_freq(note_num)
        LiedMotor.trigeight(freq)
      end
    end
  end
end

function shnth.minor(n, z)
  if z==1 then
    for i=1,4 do
      if n==i then
        local note_num = s[i+8]
        local freq = MusicUtil.note_num_to_freq(note_num)
        LiedMotor.trigeight(freq)
      end
    end
  end
end

function remap(ascii)
    ascii = ascii % 32 + 49
    return ascii
end

function crowmap(ascii)
    ascii = ascii % 32 + 1
    return ascii
end

function processString(c)
    local tempScalar = {}
      for i = 1, #c do
        table.insert(tempScalar,remap(c:byte(i)))
      end
    return tempScalar
end

function crowString(c)
    local tempScalar = {}
    for i = 1, #c do
      table.insert(tempScalar,crowmap(c:byte(i)))
    end
    return tempScalar
end

function jfmap(ascii)
    ascii = ascii % 5 + 1
    return ascii
end
  
function jfscaling(j)
    local tempScalar = {}
    for i = 1, #j do
     table.insert(tempScalar,jfmap(j:byte(i)))
    end
    return tempScalar
end

s = sequins(processString(my_string))
c = sequins(crowString(my_string))
j = sequins(jfscaling(my_string))
  
function set()
    s:settable(processString(my_string))
    c:settable(crowString(my_string))
    j:settable(jfscaling(my_string))
    local ch,length,rate = audio.file_info(selectedfile)
    local seclength = length/rate
    if seclength > 300 then seclength = seclength-300
      else seclength = seclength
    end
    starter = util.linlin(49,80,0,seclength,s:step(64)())
    softcut.buffer_read_stereo(selectedfile, starter, 0, -1, 0, 1)
end

function wcheck()
  while true do
    clock.sleep(1/30)
    if walking then
      crow.ii.wtape.play(1)
      else crow.ii.wtape.play(0)
    end
  end
end

function notes_event()
  while true do
    clock.sync(c:step(65)()/c:step(66)())
    if walking then
    crow.output[1].volts = c:step(67)()/12
    crow.output[1].slew = c:step(68)()/300
    crow.output[2].action = "{to(5,dyn{attack=1}), to(0,dyn{release=1})}"
    crow.output[2].dyn.attack = c:step(69)()/40
    crow.output[2].dyn.release = c:step(70)()/40
    crow.output[2]()
    end
  end
end

function other_event()
  while true do
    clock.sync(c:step(71)()/c:step(72)())
    if walking then
    crow.output[3].volts = c:step(73)()/12
    crow.output[3].slew = c:step(74)()/300
    crow.output[4].action = "{to(5,dyn{attack=1}), to(0,dyn{release=1})}"
    crow.output[4].dyn.attack = c:step(75)()/40
    crow.output[4].dyn.release = c:step(76)()/40
    crow.output[4]()
    end
  end
end

function jfa_event()
  while true do
    clock.sync(c:step(77)()/c:step(78)())
    if walking then
    crow.ii.jf.play_voice(1, c:step(79)()/12, j:step(80)())
    end
  end
end

function jfb_event()
  while true do
    clock.sync(c:step(81)()/c:step(82)())
    if walking then
    crow.ii.jf.play_voice(2, c:step(83)()/12, j:step(84)())
    end
  end  
end

function jfc_event()
  while true do
    clock.sync(c:step(85)()/c:step(86)())
    if walking then
    crow.ii.jf.play_voice(3, c:step(87)()/12, j:step(88)())
    end
  end
end

function jfd_event()
  while true do
    clock.sync(c:step(89)()/c:step(90)())
    if walking then
    crow.ii.jf.play_voice(4, c:step(91)()/12, j:step(92)())
    end
  end
end

function jfe_event()
  while true do
    clock.sync(c:step(93)()/c:step(94)())
    if walking then
    crow.ii.jf.play_voice(5, c:step(95)()/12, j:step(96)())
    end
  end
end

function jff_event()
  while true do
    clock.sync(c:step(97)()/c:step(98)())
    if walking then
    crow.ii.jf.play_voice(6, c:step(99)()/12, j:step(100)())
    end
  end
end

function run_event()
  while true do
    clock.sync(c:step(101)()/c:step(102)())
    if walking then
    crow.ii.jf.run(j:step(103)())
    end
  end
end

function quantize_event()
  while true do
    clock.sync(c:step(104)()/j:step(105)())
    if walking then
    crow.ii.jf.quantize(c:step(106)())
    end
  end
end

function with_event()
  while true do
    clock.sync(c:step(107)()/c:step(108)())
    if walking then
    crow.ii.wtape.speed(c:step(109)(), c:step(110)())
    end
  end
end

function rev_event()
  while true do
    clock.sync(c:step(111)()/c:step(112)())
    if walking then
    crow.ii.wtape.reverse()
    end
  end
end

function looper()
  while true do
    clock.sync(c:step(113)()/c:step(114)())
    if walking then
    crow.ii.wtape.loop_start()
    clock.sync(c:step(115)()/c:step(116)())
    crow.ii.wtape.loop_end()
      if c:step(117)() < 17 then
        for i = 1,j:step(118)() do 
          clock.sync(c:step(119)()/c:step(120)())
          crow.ii.wtape.loop_scale(c:step(121)()/c:step(122)())
          for i = 1,j:step(123)() do
            clock.sync(c:step(124)()/c:step(125)())
            crow.ii.wtape.loop_next(c:step(126)()-c:step(127)())
          end 
        end
      elseif c:step(117)() >= 17 then
        for i = 1,j:step(128)() do
          clock.sync(c:step(129)()/c:step(130)())
          crow.ii.wtape.loop_next(c:step(131)()-c:step(132)())
          for i = 1,j:step(133)() do
            clock.sync(c:step(134)()/c:step(135)())
            crow.ii.wtape.loop_scale(c:step(136)()/c:step(137)())
          end
        end
      end
    clock.sync(c:step(138)()/c:step(139)())
    crow.ii.wtape.loop_active(0)
      for i = 1,c:step(140)() do
        clock.sync(c:step(141)()/c:step(142)())
        crow.ii.wtape.seek((c:step(143)()*300)-(c:step(144)()*300))
      end
      for i = 1,j:step(145)() do
        clock.sync(c:step(146)()/c:step(147)())
        crow.ii.wtape.loop_active(1)
        if c:step(148)() < 17 then
          for i = 1,j:step(149)() do 
            clock.sync(c:step(150)()/c:step(151)())
            crow.ii.wtape.loop_scale(c:step(152)()/c:step(153)())
            for i = 1,j:step(154)() do
              clock.sync(c:step(155)()/c:step(156)())
              crow.ii.wtape.loop_next(c:step(157)()-c:step(158)())
            end 
          end
        elseif c:step(148)() >= 17 then
          for i = 1,j:step(159)() do
            clock.sync(c:step(160)()/c:step(161)())
            crow.ii.wtape.loop_next(c:step(162)()-c:step(163)())
            for i = 1,j:step(164)() do
              clock.sync(c:step(165)()/c:step(166)())
              crow.ii.wtape.loop_scale(c:step(167)()/c:step(168)())
            end
          end
        end
        clock.sync(c:step(169)()/c:step(170)())
        crow.ii.wtape.loop_active(0)
        for i = 1,c:step(171)() do
          clock.sync(c:step(171)()/c:step(172)())
          crow.ii.wtape.seek((c:step(173)()*300)-(c:step(174)()*300))
        end
      end
      end
  end
end

function withsyna_event()
  while true do
    clock.sync(c:step(175)()/c:step(176)())
    if walking then
    crow.ii.wsyn.play_voice(1, c:step(177)()/12, j:step(178)())
    end
  end
end

function withsynb_event()
  while true do
    clock.sync(c:step(179)()/c:step(180)())
    if walking then
    crow.ii.wsyn.play_voice(1, c:step(181)()/12, j:step(182)())
    end
  end
end

function withsync_event()
  while true do
    clock.sync(c:step(183)()/c:step(184)())
    if walking then
    crow.ii.wsyn.play_voice(1, c:step(185)()/12, j:step(186)())
    end
  end
end

function withsynd_event()
  while true do
    clock.sync(c:step(187)()/c:step(188)())
    if walking then
    crow.ii.wsyn.play_voice(1, c:step(189)()/12, j:step(190)())
    end
  end
end

function keyboard.char(character)
  if #my_string < 20 then
  my_string = my_string .. character -- add characters to my string
  redraw()
  elseif #my_string >=20 then
  my_string = my_string
  end
end

function keyboard.code(code,value)
  if value == 1 or value == 2 then -- 1 is down, 2 is held, 0 is release
    if code == "BACKSPACE" then
      my_string = my_string:sub(1, -2) -- erase characters from my_string
    elseif code == "UP" then
      if #history > 0 then -- make sure there's a history
        if new_line then -- reset the history index after pressing enter
          history_index = #history
          new_line = false
        else
          history_index = util.clamp(history_index - 1, 1, #history) -- increment history_index
        end
        my_string = history[history_index]
      end
    elseif code == "DOWN" then
      if #history > 0 and history_index ~= nil then -- make sure there is a history, and we are accessing it
        history_index = util.clamp(history_index + 1, 1, #history) -- decrement history_index
        my_string = history[history_index]
      end
    elseif code == "ENTER" and #my_string > 0 then
        set()
        table.insert(history, my_string) -- append the command to history
        my_string = "" -- clear my_string
        new_line = true
    end
    redraw()
    grid_redraw()
  end
end

function redraw()
  screen.clear()
  screen.level(10)
  screen.rect(2, 50, 125, 14)
  screen.stroke()
  screen.move(5,59)
  screen.text("> " .. my_string)
  if #history > 0 then
    history_index = #history -- this is always the last entered command
    screen.move(5, 45)
    screen.text(history[history_index])
    if history_index >= 2 then screen.move(5, 35) screen.text(history[history_index - 1]) end -- command before last
    if history_index >= 3 then screen.move(5, 25) screen.text(history[history_index - 2]) end -- command before the command before last
    if history_index >= 4 then screen.move(5, 15) screen.text(history[history_index - 3]) end -- command before that
    if history_index >= 5 then screen.move(5, 5) screen.text(history[history_index - 4]) end -- command before...
  end
  screen.update()
end

g = grid.connect()

function grid_redraw_clock() -- our grid redraw clock
  while true do -- while it's running...
    clock.sleep(1/30) -- refresh at 30fps.
    if grid_dirty then -- if a redraw is needed...
      grid_redraw() -- redraw...
      grid_dirty = false -- then redraw is no longer needed.
    end
  end
end

function grid_redraw()
  g:all(0)
  if #history < 17 then
    for i=1,#history do
      g:led(i,1,4)
    end
  end
  if #history >= 17 and #history < 33 then
    for i=1,16 do
      g:led(i,1,4)
    end
    for i=17,#history do
      g:led(i-16,2,4)
    end
  end
  if #history >= 33 and #history < 49 then
    for i=1,16 do
      g:led(i,1,4)
    end
    for i=17,33 do
      g:led(i-16,2,4)
    end
    for i=34,#history do
      g:led(i-33,3,4)
    end
  end
  if #history >= 49 and #history < 65 then
    for i=1,16 do
      g:led(i,1,4)
    end
    for i=17,33 do
      g:led(i-16,2,4)
    end
    for i=34,49 do
      g:led(i-33,3,4)
    end
    for i=50,#history do
      g:led(i-49,4,4)
    end
  end
  if #history >= 65 and #history < 81 then
    for i=1,16 do
      g:led(i,1,4)
    end
    for i=17,33 do
      g:led(i-16,2,4)
    end
    for i=34,49 do
      g:led(i-33,3,4)
    end
    for i=50,65 do
      g:led(i-49,4,4)
    end
    for i=66,#history do
      g:led(i-65,5,4)
    end
  end
  if #history >= 81 and #history < 97 then
    for i=1,16 do
      g:led(i,1,4)
    end
    for i=17,33 do
      g:led(i-16,2,4)
    end
    for i=34,49 do
      g:led(i-33,3,4)
    end
    for i=50,65 do
      g:led(i-49,4,4)
    end
    for i=66,81 do
      g:led(i-65,5,4)
    end
    for i=82,#history do
      g:led(i-81,6,4)
    end
  end
  if #history >= 97 and #history < 113 then
    for i=1,16 do
      g:led(i,1,4)
    end
    for i=17,33 do
      g:led(i-16,2,4)
    end
    for i=34,49 do
      g:led(i-33,3,4)
    end
    for i=50,65 do
      g:led(i-49,4,4)
    end
    for i=66,81 do
      g:led(i-65,5,4)
    end
    for i=82,97 do
      g:led(i-81,6,4)
    end
    for i=98,#history do
      g:led(i-97,7,4)
    end
  end
  if #history >= 113 and #history < 129 then
    for i=1,16 do
      g:led(i,1,4)
    end
    for i=17,33 do
      g:led(i-16,2,4)
    end
    for i=34,49 do
      g:led(i-33,3,4)
    end
    for i=50,65 do
      g:led(i-49,4,4)
    end
    for i=66,81 do
      g:led(i-65,5,4)
    end
    for i=82,97 do
      g:led(i-81,6,4)
    end
    for i=98,113 do
      g:led(i-97,7,4)
    end
    for i=114,#history do
      g:led(i-113,8,4)
    end
  end
  if #history >= 129 then
    g:all(4)
  end
   for x = 1,16 do -- for each column...
    for y = 1,8 do -- and each row...
      if momentary[x][y] then -- if the key is held...
        if x+16*(y-1) <= #history then
        g:led(x,y,15) -- turn on that LED!
        end
      end
    end
  end
  g:refresh()
end

g.key = function(x,y,z)
  momentary[x][y] = z == 1
  if x+16*(y-1) <= #history then
    if z == 1 then
      local index = x + 16*(y-1)
      if index <= #history then
        my_string = my_string .. history[index]
        redraw()
      end
    elseif z == 0 then
      local flag = false
      for j = 1,8 do
        for k = 1,16 do
          if momentary[j][k] then
            flag = true
            break
          end
        end
      end
      if not flag then
        set()
        my_string = ""
        new_line = true
        redraw()
      end
    end
  end
  grid_dirty = true -- flag for redraw
end
