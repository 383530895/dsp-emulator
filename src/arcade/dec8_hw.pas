unit dec8_hw;

interface
uses {$IFDEF WINDOWS}windows,{$ENDIF}
     m6502,m6809,main_engine,controls_engine,ym_2203,ym_3812,gfx_engine,
     rom_engine,pal_engine,sound_engine;

procedure Cargar_dec8;
procedure principal_dec8;
function iniciar_dec8:boolean;
procedure cerrar_dec8;
procedure reset_dec8;
//Main CPU
function getbyte_dec8(direccion:word):byte;
procedure putbyte_dec8(direccion:word;valor:byte);
//Sound CPU
function getbyte_snd_dec8(direccion:word):byte;
procedure putbyte_snd_dec8(direccion:word;valor:byte);
procedure dec8_sound_update;
procedure snd_irq(irqstate:byte);

implementation
const
        srd_rom:array[0..2] of tipo_roms=(
        (n:'dy01-e.b14';l:$10000;p:$0;crc:$176e9299),(n:'dy00.b16';l:$10000;p:$10000;crc:$2bf6b461),());
        srd_char:tipo_roms=(n:'dy05.b6';l:$4000;p:$0000;crc:$8780e8a3);
        srd_tiles:array[0..2] of tipo_roms=(
        (n:'dy03.b4';l:$10000;p:$0000;crc:$44f2a4f9),(n:'dy02.b5';l:$10000;p:$10000;crc:$522d9a9e),());
        srd_snd:tipo_roms=(n:'dy04.d7';l:$8000;p:$8000;crc:$2ae3591c);
        srd_sprites:array[0..6] of tipo_roms=(
        (n:'dy07.h16';l:$8000;p:$0000;crc:$97eaba60),(n:'dy06.h14';l:$8000;p:$8000;crc:$c279541b),
        (n:'dy09.k13';l:$8000;p:$10000;crc:$d30d1745),(n:'dy08.k11';l:$8000;p:$18000;crc:$71d645fd),
        (n:'dy11.k16';l:$8000;p:$20000;crc:$fd9ccc5b),(n:'dy10.k14';l:$8000;p:$28000;crc:$88770ab8),());

var
  scroll_x,i8751_return,i8751_value:word;
  rom_bank,coin1,sound_latch,vblank_val:byte;
  old_val:boolean;
  rom:array[0..5,0..$3fff] of byte;
  snd_dec:array[0..$7fff] of byte;

procedure Cargar_dec8;
begin
llamadas_maquina.iniciar:=iniciar_dec8;
llamadas_maquina.bucle_general:=principal_dec8;
llamadas_maquina.cerrar:=cerrar_dec8;
llamadas_maquina.reset:=reset_dec8;
llamadas_maquina.fps_max:=57.444583;
end;

function iniciar_dec8:boolean; 
const
    pc_x:array[0..7] of dword=($2000*8+0, $2000*8+1, $2000*8+2, $2000*8+3, 0, 1, 2, 3);
    pc_y:array[0..7] of dword=(0*8, 1*8, 2*8, 3*8, 4*8, 5*8, 6*8, 7*8);
    ps_x:array[0..15] of dword=(16*8, 1+(16*8), 2+(16*8), 3+(16*8), 4+(16*8), 5+(16*8), 6+(16*8), 7+(16*8),
		0,1,2,3,4,5,6,7);
    ps_y:array[0..15] of dword=(0*8, 1*8, 2*8, 3*8, 4*8, 5*8, 6*8, 7*8 ,8*8,9*8,10*8,11*8,12*8,13*8,14*8,15*8);
    pt_x:array[0..15] of dword=(0, 1, 2, 3, 1024*8*8+0, 1024*8*8+1, 1024*8*8+2, 1024*8*8+3,
			16*8+0, 16*8+1, 16*8+2, 16*8+3, 16*8+1024*8*8+0, 16*8+1024*8*8+1, 16*8+1024*8*8+2, 16*8+1024*8*8+3);
    pt_y:array[0..15] of dword=(0*8, 1*8, 2*8, 3*8, 4*8, 5*8, 6*8, 7*8,
			8*8, 9*8, 10*8, 11*8, 12*8, 13*8, 14*8, 15*8);
var
  f:word;
  memoria_temp,memoria_temp2:array[0..$3ffff] of byte;
begin
iniciar_dec8:=false;
iniciar_audio(false);
screen_init(1,256,256,true);
screen_init(2,256,512);
screen_mod_scroll(2,0,0,0,512,256,511);
screen_init(3,256,512,true);
screen_mod_scroll(3,0,0,0,512,256,511);
screen_init(4,256,512,false,true);
iniciar_video(240,256);
//Main CPU
main_m6809:=cpu_m6809.Create(2000000,264);
main_m6809.change_ram_calls(getbyte_dec8,putbyte_dec8);
//Sound CPU
snd_m6502:=cpu_m6502.create(1500000,264,TCPU_M6502);
snd_m6502.change_ram_calls(getbyte_snd_dec8,putbyte_snd_dec8);
snd_m6502.init_sound(dec8_sound_update);
//Sound Chip
ym2203_0:=ym2203_chip.create(0,1500000,2);
ym3812_init(0,3000000,snd_irq);
//cargar roms y ponerlas en su sitio
if not(cargar_roms(@memoria_temp[0],@srd_rom[0],'srdarwin.zip',0)) then exit;
copymemory(@rom[4,0],@memoria_temp[0],$4000);
copymemory(@rom[5,0],@memoria_temp[$4000],$4000);
copymemory(@memoria[$8000],@memoria_temp[$8000],$8000);
copymemory(@rom[0,0],@memoria_temp[$10000],$4000);
copymemory(@rom[1,0],@memoria_temp[$14000],$4000);
copymemory(@rom[2,0],@memoria_temp[$18000],$4000);
copymemory(@rom[3,0],@memoria_temp[$1c000],$4000);
//cargar roms audio y desencriptar
if not(cargar_roms(@mem_snd[0],@srd_snd,'srdarwin.zip',1)) then exit;
for f:=$8000 to $ffff do begin
		snd_dec[f-$8000]:=(mem_snd[f] and $9f)+((mem_snd[f] and $20) shl 1)+((mem_snd[f] and $40) shr 1);
end;
//Cargar chars
if not(cargar_roms(@memoria_temp[0],@srd_char,'srdarwin.zip',1)) then exit;
init_gfx(0,8,8,$400);
gfx[0].trans[0]:=true;
gfx_set_desc_data(2,0,8*8,0,4);
convert_gfx(0,0,@memoria_temp[0],@pc_x[0],@pc_y[0],false,true);
//Cargar tiles y ponerlas en su sitio
if not(cargar_roms(@memoria_temp[0],@srd_tiles[0],'srdarwin.zip',0)) then exit;
for f:=0 to 3 do copymemory(@memoria_temp2[$10000*f],@memoria_temp[$4000*f],$4000);
for f:=0 to 3 do copymemory(@memoria_temp2[$8000+($10000*f)],@memoria_temp[$10000+($4000*f)],$4000);
init_gfx(1,16,16,$400);
for f:=0 to 7 do gfx[1].trans[f]:=true;
gfx_set_desc_data(4,4,32*8,$8000*8,$8000*8+4,0,4);
for f:=0 to 3 do
  convert_gfx(1,$100*f*16*16,@memoria_temp2[$10000*f],@pt_x[0],@pt_y[0],false,true);
//Cargar sprites
if not(cargar_roms(@memoria_temp[0],@srd_sprites[0],'srdarwin.zip',0)) then exit;
init_gfx(2,16,16,$800);
gfx[2].trans[0]:=true;
gfx_set_desc_data(3,0,16*16,$10000*8,$20000*8,$0*8);
convert_gfx(2,0,@memoria_temp[0],@ps_x[0],@ps_y[0],false,true);
//final
reset_dec8;
iniciar_dec8:=true;
end;

procedure cerrar_dec8;
begin
main_m6809.Free;
snd_m6502.free;
ym2203_0.Free;
ym3812_close(0);
close_audio;
close_video;
end;

procedure reset_dec8;
begin
main_m6809.reset;
snd_m6502.reset;
ym2203_0.reset;
ym3812_reset(0);
marcade.in0:=$ff;
marcade.in1:=$ff;
marcade.in2:=$ff;
sound_latch:=0;
old_val:=false;
rom_bank:=0;
i8751_return:=0;
i8751_value:=0;
scroll_x:=0;
end;

procedure draw_sprites(pri:byte);inline;
var
  f,nchar:word;
  color,atrib:byte;
  x,y:word;
  flipy:boolean;
begin
  for f:=0 to $7f do begin
    atrib:=buffer_sprites[(f*4)+1];
		color:=(atrib and $03)+((atrib and $08) shr 1);
		if ((pri=0) and (color<>0)) then continue;
		if ((pri=1) and (color=0)) then continue;
		nchar:=buffer_sprites[(f*4)+3]+((atrib and $e0) shl 3);
		if (nchar=0) then continue;
		x:=buffer_sprites[f*4];
		y:=buffer_sprites[(f*4)+2];
		flipy:=(atrib and $04)<>0;
		if (atrib and $10)<>0 then begin
      put_gfx_sprite_diff(nchar,$40+(color shl 3),false,flipy,2,0,0);
      put_gfx_sprite_diff(nchar+1,$40+(color shl 3),false,flipy,2,16,0);
      actualiza_gfx_sprite_size(x,y,4,32,16);
    end else begin
      put_gfx_sprite(nchar,$40+(color shl 3),false,flipy,2);
      actualiza_gfx_sprite(x,y,4,2);
    end;
	end;
end;

procedure update_video_dec8;inline;
var
  f,nchar,color,atrib:word;
  x,y:word;
begin
for f:=0 to $1ff do begin
    atrib:=memoria[$1400+(f*2)];
    color:=(atrib and $f0) shr 4;
    if (gfx[1].buffer[f] or buffer_color[color]) then begin
      x:=f div 32;
      y:=31-(f mod 32);
      nchar:=memoria[$1401+(f*2)]+((atrib and $3) shl 8);
      put_gfx(x*16,y*16,nchar,color shl 4,2,1);
      if color=0 then put_gfx_block_trans(x*16,y*16,3,16,16)
        else put_gfx_trans(x*16,y*16,nchar,color shl 4,3,1);
      gfx[1].buffer[f]:=false;
    end;
end;
scroll__y(2,4,256-scroll_x);
draw_sprites(0);
scroll__y(3,4,256-scroll_x);
draw_sprites(1);
//Foreground
for f:=0 to $3ff do begin
  if gfx[0].buffer[f] then begin
    x:=f div 32;
    y:=31-(f mod 32);
    nchar:=memoria[$800+f];
    put_gfx_trans(x*8,y*8,nchar,$80,1,0);
    gfx[0].buffer[f]:=false;
 end;
end;
actualiza_trozo(0,0,256,256,1,0,0,256,256,4);
actualiza_trozo_final(8,0,240,256,4);
fillchar(buffer_color[0],MAX_COLOR_BUFFER,0);
end;

procedure eventos_dec8;
begin
if event.arcade then begin
  if arcade_input.right[0] then marcade.in0:=marcade.in0 and $fe else marcade.in0:=marcade.in0 or 1;
  if arcade_input.left[0] then marcade.in0:=marcade.in0 and $fd else marcade.in0:=marcade.in0 or 2;
  if arcade_input.up[0] then marcade.in0:=marcade.in0 and $fb else marcade.in0:=marcade.in0 or 4;
  if arcade_input.down[0] then marcade.in0:=marcade.in0 and $f7 else marcade.in0:=marcade.in0 or 8;
  if arcade_input.but0[0] then marcade.in0:=marcade.in0 and $ef else marcade.in0:=marcade.in0 or $10;
  if arcade_input.but1[0] then marcade.in0:=marcade.in0 and $df else marcade.in0:=marcade.in0 or $20;
  if arcade_input.start[0] then marcade.in0:=marcade.in0 and $bf else marcade.in0:=marcade.in0 or $40;
  if arcade_input.start[1] then marcade.in0:=marcade.in0 and $7f else marcade.in0:=marcade.in0 or $80;
  if (arcade_input.coin[0] and not(old_val)) then coin1:=coin1+1;
  old_val:=arcade_input.coin[0];
end;
end;

procedure principal_dec8;
var
  frame_m,frame_s:single;
  f:word;
begin
init_controls(false,false,false,true);
frame_m:=main_m6809.tframes;
frame_s:=snd_m6502.tframes;
while EmuStatus=EsRuning do begin
 for f:=0 to 263 do begin
   //Main
   main_m6809.run(frame_m);
   frame_m:=frame_m+main_m6809.tframes-main_m6809.contador;
   //Sound
   snd_m6502.run(frame_s);
   frame_s:=frame_s+snd_m6502.tframes-snd_m6502.contador;
   case f of
      247:begin
            main_m6809.pedir_nmi:=PULSE_LINE;
            update_video_dec8;
            vblank_val:=0;
      end;
      263:vblank_val:=$40;
   end;
 end;
 eventos_dec8;
 video_sync;
end;
end;

function getbyte_dec8(direccion:word):byte;
begin
case direccion of
   $0..$17ff:getbyte_dec8:=memoria[direccion];
   $2800..$288f:getbyte_dec8:=memoria[direccion];
   $3000..$308f:getbyte_dec8:=memoria[direccion];
   $2000:getbyte_dec8:=i8751_return shr 8;
   $2001:getbyte_dec8:=i8751_return and $ff;
   $3800:getbyte_dec8:=$7f;
   $3801:getbyte_dec8:=marcade.in0;
   $3802:getbyte_dec8:=marcade.in1+vblank_val;
   $3803:getbyte_dec8:=$8f;
   $4000..$7fff:getbyte_dec8:=rom[rom_bank,direccion and $3fff];
   $8000..$ffff:getbyte_dec8:=memoria[direccion];
end;
end;

procedure evalue_i8751;inline;
begin
  i8751_return:=0;
  if (i8751_value=$0000) then coin1:=0;
	if (i8751_value=$3063) then i8751_return:=$9c;				// Protection - Japanese version */
	if (i8751_value=$306b) then i8751_return:=$94;				// Protection - World version */
	if ((i8751_value and $ff00)=$4000) then i8751_return:=i8751_value;	// Coinage settings */
	if (i8751_value=$5000) then i8751_return:=((coin1 div 10) shl 4)+(coin1 mod 10);	// Coin request */
	if (i8751_value=$6000) then begin  // Coin clear */
    i8751_value:=$FFFF;
    coin1:=coin1-1;
  end;
	if (i8751_value=$8000) then i8751_return:= $f580 +  0; // Boss #1: Snake + Bees */
	if (i8751_value=$8001) then i8751_return:= $f580 + 30; // Boss #2: 4 Corners */
	if (i8751_value=$8002) then i8751_return:= $f580 + 26; // Boss #3: Clock */
	if (i8751_value=$8003) then i8751_return:= $f580 +  2; // Boss #4: Pyramid */
	if (i8751_value=$8004) then i8751_return:= $f580 +  6; // Boss #5: Snake + Head Combo */
	if (i8751_value=$8005) then i8751_return:= $f580 + 24; // Boss #6: LED Panels */
	if (i8751_value=$8006) then i8751_return:= $f580 + 28; // Boss #7: Dragon */
	if (i8751_value=$8007) then i8751_return:= $f580 + 32; // Boss #8: Teleport */
	if (i8751_value=$8008) then i8751_return:= $f580 + 38; // Boss #9: Octopus (Pincer) */
	if (i8751_value=$8009) then i8751_return:= $f580 + 40; // Boss #10: Bird */
	if (i8751_value=$800a) then i8751_return:= $f580 + 42; // End Game(bad address?) */
end;

procedure cambiar_color(dir:word);inline;
var
  tmp_color:byte;
  color:tcolor;
begin
  tmp_color:=buffer_paleta[dir];
  color.r:=pal4bit(tmp_color);
  color.g:=pal4bit(tmp_color shr 4);
  tmp_color:=buffer_paleta[dir+$100];
  color.b:=pal4bit(tmp_color);
  set_pal_color(color,@paleta[dir]);
  buffer_color[(dir shr 4) and $f]:=true;
end;

procedure putbyte_dec8(direccion:word;valor:byte);
begin
if direccion>$3fff then exit;
memoria[direccion]:=valor;
case direccion of
  $1400..$17ff:gfx[1].buffer[(direccion and $3ff) shr 1]:=true;
  $800..$bff:gfx[0].buffer[direccion and $3ff]:=true;
  $1800:begin
          i8751_value:=(i8751_value and $ff) or (valor shl 8);
          evalue_i8751;
        end;
  $1801:begin
          i8751_value:=(i8751_value and $ff00) or valor;
          evalue_i8751;
        end;
  $1802:i8751_return:=0;
  $1804:copymemory(@buffer_sprites[0],@memoria[$600],$200); //DMA
  $1805:begin
          rom_bank:=valor shr 5;
          scroll_x:=(scroll_x and $ff) or ((valor and $f) shl 8);
        end;
  $1806:scroll_x:=(scroll_x and $f00) or valor;
  $2000:begin
        sound_latch:=valor;
        snd_m6502.pedir_nmi:=PULSE_LINE;
        end;
  $2800..$288f:if buffer_paleta[direccion and $ff]<>valor then begin
          buffer_paleta[direccion and $ff]:=valor;
          cambiar_color(direccion and $ff);
        end;
  $3000..$308f:if buffer_paleta[(direccion and $ff)+$100]<>valor then begin
          buffer_paleta[(direccion and $ff)+$100]:=valor;
          cambiar_color(direccion and $ff);
        end;
end;
end;

function getbyte_snd_dec8(direccion:word):byte;
begin
  case direccion of
    $2000:getbyte_snd_dec8:=ym2203_0.read_status;
    $2001:getbyte_snd_dec8:=ym2203_0.Read_Reg;
    $4000:getbyte_snd_dec8:=ym3812_status_port(0);
    $6000:getbyte_snd_dec8:=sound_latch;
    $8000..$ffff:if snd_m6502.opcode then getbyte_snd_dec8:=snd_dec[direccion and $7fff]
                    else getbyte_snd_dec8:=mem_snd[direccion];
    else getbyte_snd_dec8:=mem_snd[direccion];
  end;
end;

procedure putbyte_snd_dec8(direccion:word;valor:byte);
begin
if direccion>$7fff then exit;
mem_snd[direccion]:=valor;
case direccion of
  $2000:ym2203_0.control(valor);
  $2001:ym2203_0.write_reg(valor);
  $4000:ym3812_control_port(0,valor);
  $4001:ym3812_write_port(0,valor);
end;
end;

procedure dec8_sound_update;
begin
  ym2203_0.Update;
  ym3812_Update(0);
end;

procedure snd_irq(irqstate:byte);
begin
  if (irqstate<>0) then snd_m6502.pedir_irq:=ASSERT_LINE
    else snd_m6502.pedir_irq:=CLEAR_LINE;
end;

end.
