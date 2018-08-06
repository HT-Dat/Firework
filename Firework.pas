{$APPTYPE GUI}
program Firework;
uses wingraph,wincrt;
var mh,mode:smallint;
  i,j:integer;
  x:array[1..30,1..200] of integer;
  y:array[1..30,1..200] of integer;
  V:array[1..30,1..200] of integer;
  t:array[1..30,1..200] of real;
  Fly:array[1..30] of boolean;
  Explosion:array[1..30] of boolean;
  alpha:array[1..30,1..2000] of extended;
  colors:array[1..30] of integer;
Procedure Start;
var tam:integer;
Begin
  randomize;
  For i:=1 to 20 do
    For j:=1 to 200 do
      Begin
        tam:=random(360);
        while tam mod 90 = 0 do tam:=random(360);
        alpha[i][j]:=tam*pi/180;
      end;
  mh:=VGA;
  mode:=m1024x768;
  initgraph(mh,mode,'FireWork trend by Bolun');
  fillchar(fly,sizeof(fly),false);
  fillchar(Explosion,sizeof(Explosion),false);
End;
Procedure BigFly;
Begin
  y[i][1]:=850-round(100+V[i][1]*t[i][1]-0.5*0.5*t[i][1]*t[i][1]);
  if y[i][1]>851 then fly[i]:=false;
  t[i][1]:=t[i][1]+0.5;
End;
Procedure StartOver;
var e:integer;
Begin
  colors[i]:=1+random(255);
  fly[i]:=true;
  explosion[i]:=false;
  t[i][1]:=0;
  v[i][1]:=20+random(7);
  for e:=2 to 200 do
    begin
      t[i][e]:=0;
      v[i][e]:=(1+random(10));
    end;
  x[i][1]:=1+random(1024);
End;
Procedure Draw;
begin
  bar(x[i][1],y[i][1],x[i][1]+15,y[i][1]+15);
end;
Procedure DrawSmall;
Begin
  bar(x[i][j],y[i][j],x[i][j]+5,y[i][j]+5)
end;

Procedure SmallFly;
Begin
  For j:=2 to 175 do
    Begin
      t[i][j]:=t[i][j]+0.5;
      x[i][j]:=x[i][1]+round(V[i][j]*cos(alpha[i][j])*t[i][j]);
      y[i][j]:=y[i][1]+round(v[i][j]*sin(alpha[i][j])*t[i][j]+0.5*sqr(t[i][j])/2);
      DrawSmall;
    end;
End;
begin
  Start;
  UpdateGraph(UpdateOff);
  While not keypressed do
    Begin
      for i:=1 to 15 do
        Begin
          if (Fly[i]=false) then StartOver
          else
            Begin
              SetFillStyle(SolidFill,colors[i]);
              BigFly;
              if (y[i][1]<=750-sqr(v[i][1])/(2*0.5)) and (Explosion[i]=false) then Explosion[i]:=true;
              if Explosion[i]=false then Draw
              else SmallFly;
            end;
        End;
      UpdateGraph(UpdateNow);
      delay(10);
      clearDevice;
    end;
  readln;
end.


