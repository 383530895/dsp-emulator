unit galaga_stars_const;

interface

type
  galaga_star=record
	  x,y:word;
	  col,set_:byte;
  end;

const
  star_seed_tab:array[0..251] of galaga_star=(
// star set 0 */
(x:$0085;y:$0006;col:$35;set_:$00),
(x:$008F;y:$0008;col:$30;set_:$00),
(x:$00E5;y:$001B;col:$07;set_:$00),
(x:$0022;y:$001C;col:$31;set_:$00),
(x:$00E5;y:$0025;col:$1D;set_:$00),
(x:$0015;y:$0026;col:$29;set_:$00),
(x:$0080;y:$002D;col:$3B;set_:$00),
(x:$0097;y:$002E;col:$1C;set_:$00),
(x:$00BA;y:$003B;col:$05;set_:$00),
(x:$0036;y:$003D;col:$36;set_:$00),
(x:$0057;y:$0044;col:$09;set_:$00),
(x:$00CF;y:$0044;col:$3D;set_:$00),
(x:$0061;y:$004E;col:$27;set_:$00),
(x:$0087;y:$0064;col:$1A;set_:$00),
(x:$00D6;y:$0064;col:$17;set_:$00),
(x:$000B;y:$006C;col:$3C;set_:$00),
(x:$0006;y:$006D;col:$24;set_:$00),
(x:$0018;y:$006E;col:$3A;set_:$00),
(x:$00A9;y:$0079;col:$23;set_:$00),
(x:$008A;y:$007B;col:$11;set_:$00),
(x:$00D6;y:$0080;col:$0C;set_:$00),
(x:$0067;y:$0082;col:$3F;set_:$00),
(x:$0039;y:$0083;col:$38;set_:$00),
(x:$0072;y:$0083;col:$14;set_:$00),
(x:$00EC;y:$0084;col:$16;set_:$00),
(x:$008E;y:$0085;col:$10;set_:$00),
(x:$0020;y:$0088;col:$25;set_:$00),
(x:$0095;y:$008A;col:$0F;set_:$00),
(x:$000E;y:$008D;col:$00;set_:$00),
(x:$0006;y:$0091;col:$2E;set_:$00),
(x:$0007;y:$0094;col:$0D;set_:$00),
(x:$00AE;y:$0097;col:$0B;set_:$00),
(x:$0000;y:$0098;col:$2D;set_:$00),
(x:$0086;y:$009B;col:$01;set_:$00),
(x:$0058;y:$00A1;col:$34;set_:$00),
(x:$00FE;y:$00A1;col:$3E;set_:$00),
(x:$00A2;y:$00A8;col:$1F;set_:$00),
(x:$0041;y:$00AA;col:$0A;set_:$00),
(x:$003F;y:$00AC;col:$32;set_:$00),
(x:$00DE;y:$00AC;col:$03;set_:$00),
(x:$00D4;y:$00B9;col:$26;set_:$00),
(x:$006D;y:$00BB;col:$1B;set_:$00),
(x:$0062;y:$00BD;col:$39;set_:$00),
(x:$00C9;y:$00BE;col:$18;set_:$00),
(x:$006C;y:$00C1;col:$04;set_:$00),
(x:$0059;y:$00C3;col:$21;set_:$00),
(x:$0060;y:$00CC;col:$0E;set_:$00),
(x:$0091;y:$00CC;col:$12;set_:$00),
(x:$003F;y:$00CF;col:$06;set_:$00),
(x:$00F7;y:$00CF;col:$22;set_:$00),
(x:$0044;y:$00D0;col:$33;set_:$00),
(x:$0034;y:$00D2;col:$08;set_:$00),
(x:$00D3;y:$00D9;col:$20;set_:$00),
(x:$0071;y:$00DD;col:$37;set_:$00),
(x:$0073;y:$00E1;col:$2C;set_:$00),
(x:$00B9;y:$00E3;col:$2F;set_:$00),
(x:$00A9;y:$00E4;col:$13;set_:$00),
(x:$00D3;y:$00E7;col:$19;set_:$00),
(x:$0037;y:$00ED;col:$02;set_:$00),
(x:$00BD;y:$00F4;col:$15;set_:$00),
(x:$000F;y:$00F6;col:$28;set_:$00),
(x:$004F;y:$00F7;col:$2B;set_:$00),
(x:$00FB;y:$00FF;col:$2A;set_:$00),
// star set 1 */
(x:$00FE;y:$0004;col:$3D;set_:$01),
(x:$00C4;y:$0006;col:$10;set_:$01),
(x:$001E;y:$0007;col:$2D;set_:$01),
(x:$0083;y:$000B;col:$1F;set_:$01),
(x:$002E;y:$000D;col:$3C;set_:$01),
(x:$001F;y:$000E;col:$00;set_:$01),
(x:$00D8;y:$000E;col:$2C;set_:$01),
(x:$0003;y:$000F;col:$17;set_:$01),
(x:$0095;y:$0011;col:$3F;set_:$01),
(x:$006A;y:$0017;col:$35;set_:$01),
(x:$00CC;y:$0017;col:$02;set_:$01),
(x:$0000;y:$0018;col:$32;set_:$01),
(x:$0092;y:$001D;col:$36;set_:$01),
(x:$00E3;y:$0021;col:$04;set_:$01),
(x:$002F;y:$002D;col:$37;set_:$01),
(x:$00F0;y:$002F;col:$0C;set_:$01),
(x:$009B;y:$003E;col:$06;set_:$01),
(x:$00A4;y:$004C;col:$07;set_:$01),
(x:$00EA;y:$004D;col:$13;set_:$01),
(x:$0084;y:$004E;col:$21;set_:$01),
(x:$0033;y:$0052;col:$0F;set_:$01),
(x:$0070;y:$0053;col:$0E;set_:$01),
(x:$0006;y:$0059;col:$08;set_:$01),
(x:$0081;y:$0060;col:$28;set_:$01),
(x:$0037;y:$0061;col:$29;set_:$01),
(x:$008F;y:$0067;col:$2F;set_:$01),
(x:$001B;y:$006A;col:$1D;set_:$01),
(x:$00BF;y:$007C;col:$12;set_:$01),
(x:$0051;y:$007F;col:$31;set_:$01),
(x:$0061;y:$0086;col:$25;set_:$01),
(x:$006A;y:$008F;col:$0D;set_:$01),
(x:$006A;y:$0091;col:$19;set_:$01),
(x:$0090;y:$0092;col:$05;set_:$01),
(x:$003B;y:$0096;col:$24;set_:$01),
(x:$008C;y:$0097;col:$0A;set_:$01),
(x:$0006;y:$0099;col:$03;set_:$01),
(x:$0038;y:$0099;col:$38;set_:$01),
(x:$00A8;y:$0099;col:$18;set_:$01),
(x:$0076;y:$00A6;col:$20;set_:$01),
(x:$00AD;y:$00A6;col:$1C;set_:$01),
(x:$00EC;y:$00A6;col:$1E;set_:$01),
(x:$0086;y:$00AC;col:$15;set_:$01),
(x:$0078;y:$00AF;col:$3E;set_:$01),
(x:$007B;y:$00B3;col:$09;set_:$01),
(x:$0027;y:$00B8;col:$39;set_:$01),
(x:$0088;y:$00C2;col:$23;set_:$01),
(x:$0044;y:$00C3;col:$3A;set_:$01),
(x:$00CF;y:$00C5;col:$34;set_:$01),
(x:$0035;y:$00C9;col:$30;set_:$01),
(x:$006E;y:$00D1;col:$3B;set_:$01),
(x:$00D6;y:$00D7;col:$16;set_:$01),
(x:$003A;y:$00D9;col:$2B;set_:$01),
(x:$00AB;y:$00E0;col:$11;set_:$01),
(x:$00E0;y:$00E2;col:$1B;set_:$01),
(x:$006F;y:$00E6;col:$0B;set_:$01),
(x:$00B8;y:$00E8;col:$14;set_:$01),
(x:$00D9;y:$00E8;col:$1A;set_:$01),
(x:$00F9;y:$00E8;col:$22;set_:$01),
(x:$0004;y:$00F1;col:$2E;set_:$01),
(x:$0049;y:$00F8;col:$26;set_:$01),
(x:$0010;y:$00F9;col:$01;set_:$01),
(x:$0039;y:$00FB;col:$33;set_:$01),
(x:$0028;y:$00FC;col:$27;set_:$01),
// star set 2 */
(x:$00FA;y:$0006;col:$19;set_:$02),
(x:$00E4;y:$0007;col:$2D;set_:$02),
(x:$0072;y:$000A;col:$03;set_:$02),
(x:$0084;y:$001B;col:$00;set_:$02),
(x:$00BA;y:$001D;col:$29;set_:$02),
(x:$00E3;y:$0022;col:$04;set_:$02),
(x:$00D1;y:$0026;col:$2A;set_:$02),
(x:$0089;y:$0032;col:$30;set_:$02),
(x:$005B;y:$0036;col:$27;set_:$02),
(x:$0084;y:$003A;col:$36;set_:$02),
(x:$0053;y:$003F;col:$0D;set_:$02),
(x:$0008;y:$0040;col:$1D;set_:$02),
(x:$0055;y:$0040;col:$1A;set_:$02),
(x:$00AA;y:$0041;col:$31;set_:$02),
(x:$00FB;y:$0041;col:$2B;set_:$02),
(x:$00BC;y:$0046;col:$16;set_:$02),
(x:$0093;y:$0052;col:$39;set_:$02),
(x:$00B9;y:$0057;col:$10;set_:$02),
(x:$0054;y:$0059;col:$28;set_:$02),
(x:$00E6;y:$005A;col:$01;set_:$02),
(x:$00A7;y:$005D;col:$1B;set_:$02),
(x:$002D;y:$005E;col:$35;set_:$02),
(x:$0014;y:$0062;col:$21;set_:$02),
(x:$0069;y:$006D;col:$1F;set_:$02),
(x:$00CE;y:$006F;col:$0B;set_:$02),
(x:$00DF;y:$0075;col:$2F;set_:$02),
(x:$00CB;y:$0077;col:$12;set_:$02),
(x:$004E;y:$007C;col:$23;set_:$02),
(x:$004A;y:$0084;col:$0F;set_:$02),
(x:$0012;y:$0086;col:$25;set_:$02),
(x:$0068;y:$008C;col:$32;set_:$02),
(x:$0003;y:$0095;col:$20;set_:$02),
(x:$000A;y:$009C;col:$17;set_:$02),
(x:$005B;y:$00A3;col:$08;set_:$02),
(x:$005F;y:$00A4;col:$3E;set_:$02),
(x:$0072;y:$00A4;col:$2E;set_:$02),
(x:$00CC;y:$00A6;col:$06;set_:$02),
(x:$008A;y:$00AB;col:$0C;set_:$02),
(x:$00E0;y:$00AD;col:$26;set_:$02),
(x:$00F3;y:$00AF;col:$0A;set_:$02),
(x:$0075;y:$00B4;col:$13;set_:$02),
(x:$0068;y:$00B7;col:$11;set_:$02),
(x:$006D;y:$00C2;col:$2C;set_:$02),
(x:$0076;y:$00C3;col:$14;set_:$02),
(x:$00CF;y:$00C4;col:$1E;set_:$02),
(x:$0004;y:$00C5;col:$1C;set_:$02),
(x:$0013;y:$00C6;col:$3F;set_:$02),
(x:$00B9;y:$00C7;col:$3C;set_:$02),
(x:$0005;y:$00D7;col:$34;set_:$02),
(x:$0095;y:$00D7;col:$3A;set_:$02),
(x:$00FC;y:$00D8;col:$02;set_:$02),
(x:$00E7;y:$00DC;col:$09;set_:$02),
(x:$001D;y:$00E1;col:$05;set_:$02),
(x:$0005;y:$00E6;col:$33;set_:$02),
(x:$001C;y:$00E9;col:$3B;set_:$02),
(x:$00A2;y:$00ED;col:$37;set_:$02),
(x:$0028;y:$00EE;col:$07;set_:$02),
(x:$00DD;y:$00EF;col:$18;set_:$02),
(x:$006D;y:$00F0;col:$38;set_:$02),
(x:$00A1;y:$00F2;col:$0E;set_:$02),
(x:$0074;y:$00F7;col:$3D;set_:$02),
(x:$0069;y:$00F9;col:$22;set_:$02),
(x:$003F;y:$00FF;col:$24;set_:$02),
// star set 3 */
(x:$0071;y:$0010;col:$34;set_:$03),
(x:$00AF;y:$0011;col:$23;set_:$03),
(x:$00A0;y:$0014;col:$26;set_:$03),
(x:$0002;y:$0017;col:$02;set_:$03),
(x:$004B;y:$0019;col:$31;set_:$03),
(x:$0093;y:$001C;col:$0E;set_:$03),
(x:$001B;y:$001E;col:$25;set_:$03),
(x:$0032;y:$0020;col:$2E;set_:$03),
(x:$00EE;y:$0020;col:$3A;set_:$03),
(x:$0079;y:$0022;col:$2F;set_:$03),
(x:$006C;y:$0023;col:$17;set_:$03),
(x:$00BC;y:$0025;col:$11;set_:$03),
(x:$0041;y:$0029;col:$30;set_:$03),
(x:$001C;y:$002E;col:$32;set_:$03),
(x:$00B9;y:$0031;col:$01;set_:$03),
(x:$0083;y:$0032;col:$05;set_:$03),
(x:$0095;y:$003A;col:$12;set_:$03),
(x:$000D;y:$003F;col:$07;set_:$03),
(x:$0020;y:$0041;col:$33;set_:$03),
(x:$0092;y:$0045;col:$2C;set_:$03),
(x:$00D4;y:$0047;col:$08;set_:$03),
(x:$00A1;y:$004B;col:$2D;set_:$03),
(x:$00D2;y:$004B;col:$3B;set_:$03),
(x:$00D6;y:$0052;col:$24;set_:$03),
(x:$009A;y:$005F;col:$1C;set_:$03),
(x:$0016;y:$0060;col:$3D;set_:$03),
(x:$001A;y:$0063;col:$1F;set_:$03),
(x:$00CD;y:$0066;col:$28;set_:$03),
(x:$00FF;y:$0067;col:$10;set_:$03),
(x:$0035;y:$0069;col:$20;set_:$03),
(x:$008F;y:$006C;col:$04;set_:$03),
(x:$00CA;y:$006C;col:$2A;set_:$03),
(x:$005A;y:$0074;col:$09;set_:$03),
(x:$0060;y:$0078;col:$38;set_:$03),
(x:$0072;y:$0079;col:$1E;set_:$03),
(x:$0037;y:$007F;col:$29;set_:$03),
(x:$0012;y:$0080;col:$14;set_:$03),
(x:$0029;y:$0082;col:$2B;set_:$03),
(x:$0084;y:$0098;col:$36;set_:$03),
(x:$0032;y:$0099;col:$37;set_:$03),
(x:$00BB;y:$00A0;col:$19;set_:$03),
(x:$003E;y:$00A3;col:$3E;set_:$03),
(x:$004A;y:$00A6;col:$1A;set_:$03),
(x:$0029;y:$00A7;col:$21;set_:$03),
(x:$009D;y:$00B7;col:$22;set_:$03),
(x:$006C;y:$00B9;col:$15;set_:$03),
(x:$000C;y:$00C0;col:$0A;set_:$03),
(x:$00C2;y:$00C3;col:$0F;set_:$03),
(x:$002F;y:$00C9;col:$0D;set_:$03),
(x:$00D2;y:$00CE;col:$16;set_:$03),
(x:$00F3;y:$00CE;col:$0B;set_:$03),
(x:$0075;y:$00CF;col:$27;set_:$03),
(x:$001A;y:$00D5;col:$35;set_:$03),
(x:$0026;y:$00D6;col:$39;set_:$03),
(x:$0080;y:$00DA;col:$3C;set_:$03),
(x:$00A9;y:$00DD;col:$00;set_:$03),
(x:$00BC;y:$00EB;col:$03;set_:$03),
(x:$0032;y:$00EF;col:$1B;set_:$03),
(x:$0067;y:$00F0;col:$3F;set_:$03),
(x:$00EF;y:$00F1;col:$18;set_:$03),
(x:$00A8;y:$00F3;col:$0C;set_:$03),
(x:$00DE;y:$00F9;col:$1D;set_:$03),
(x:$002C;y:$00FA;col:$13;set_:$03));

implementation

end.
