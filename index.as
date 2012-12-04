import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;

var timer:Timer = new Timer(1000,60);
timer.addEventListener(TimerEvent.TIMER,sayac);
var sn:Number = 0;
var dk:Number = 1;
var dakika:String;
var saniye:String;
var puan:int;
puanT.text=puan.toString();
timer.start();
function sayac(e:TimerEvent)
{
	if (sn<10)
	{
		saniye = '0' + sn.toString();
	}
	else
	{
		saniye = sn.toString();
	}
	if (dk<10)
	{
		dakika = '0' + dk.toString();
	}
	else
	{
		dakika = dk.toString();
	}
	süre.text = dakika + ':' + saniye;
	sn--;
	if (sn<=0)
	{
		dk--;
		sn = 59;
	}
}
timer.addEventListener(TimerEvent.TIMER_COMPLETE,bitti);
function bitti(e:TimerEvent)
{
	trace('bitti');
}
var soru:sor = new sor(1);
soru.soruUret();
soruT.text = soru.soru;
cevapYerlestir();
stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
function kaydir(mouse:MouseEvent)
{
	yay_mc.x = mouse.stageX;
	ok_mc.x = mouse.stageX;
}
stage.addEventListener(MouseEvent.CLICK,okat);
var T:Timer = new Timer(10);
T.start();
function okat(mouse:MouseEvent)
{
	yay_mc.gotoAndPlay(2);
	stage.removeEventListener(MouseEvent.MOUSE_MOVE,kaydir);
	T.addEventListener(TimerEvent.TIMER,firlat);
	trace('zamanlayıcı  başladı ok.y='+ok_mc.y);
	function firlat(t:TimerEvent)
	{
		if (ok_mc.y >= 0)
		{
			ok_mc.y -=  20;
		}
		else
		{
			T.removeEventListener(TimerEvent.TIMER,firlat);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			ok_mc.y = 629.7;
		}
		if (ok_mc.hitTestObject(dogruCevap()))
		{
			trace('doğru');
			dogruBalon.gotoAndPlay(2);
			puan+=10;
			puanT.text=puan.toString();
			soru.soruUret();
			soruT.text = soru.soru;
			cevapYerlestir();
		}
	}
}
/**
 * cevapYerlestir
 *
 * balonler üzerine cevaplar yerleştirir
 */
var a:Array;
// doğru şıkkı  seç
var dogruIndexNo:int;
function cevapYerlestir()
{
	a = ['A','B','C','D'];
	dogruIndexNo = soru.rasgele(0,3);
	trace(dogruIndexNo);
	var ds:String = a[dogruIndexNo];
	var cevaplar:Array = new Array(4);
	cevaplar[0]=soru.cevap;
	var i:int;
	for (i=1; i<4; i++)
	{
		var rCevap:int=soru.rasgele((soru.cevap-5),(soru.cevap+5));
		while (cevaplar.lastIndexOf(rCevap)>=0)
		{
			rCevap=soru.rasgele((soru.cevap-5),(soru.cevap+5));
		}
		cevaplar[i] = rCevap;
	}
	var gecici:int = cevaplar[dogruIndexNo];
	cevaplar[dogruIndexNo] = soru.cevap;
	cevaplar[0] = gecici;
	for (i=0; i<4; i++)
	{
		switch (i)
		{
			case 0 :
				A.text = cevaplar[i].toString();
				break;
			case 1 :
				B.text = cevaplar[i].toString();
				break;
			case 2 :
				C.text = cevaplar[i].toString();
				break;
			case 3 :
				D.text = cevaplar[i].toString();
				break;
		}
	}
}
/**
 * dogruBalon
 *
 * doğru cevabın olduğu balonu  belirler
 */
var dogruBalon:Object;
function dogruCevap()
{
	switch (a[dogruIndexNo])
	{
		case 'A' :
			dogruBalon = Abalon;
			break;
		case 'B' :
			dogruBalon = Bbalon;
			break;
		case 'C' :
			dogruBalon = Cbalon;
			break;
		case 'D' :
			dogruBalon = Dbalon;
			break;
	}
	return dogruBalon;
}