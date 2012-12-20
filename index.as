import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;

var timer:Timer = new Timer(1000,60);
timer.addEventListener(TimerEvent.TIMER,sayac);
var sn:Number = 59;
var dk:Number = 0;
var dakika:String;
var saniye:String;
var puan:int=0;
var birak:Boolean = false;//okbırakıldı anlamında
var atildi:Boolean = false;//yay bırakıldı anlamında

puanT.text = puan.toString();
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
	gotoAndStop(2);
	skorT.text = puan.toString();
stage.removeEventListener(MouseEvent.MOUSE_MOVE,kaydir);
yenidenOyna.addEventListener(MouseEvent.CLICK,function(){gotoAndStop(1)});
puan = 0;
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
stage.addEventListener(MouseEvent.CLICK,function(){birak=true;atildi=true;});
stage.addEventListener(Event.ENTER_FRAME,calistir);
function calistir(mouse:Event)
{
	if (birak)
	{
		if (atildi)
		{
			yay_mc.gotoAndPlay(2);
		}
		atildi = false;
		stage.removeEventListener(MouseEvent.MOUSE_MOVE,kaydir);
		if (ok_mc.y >= 0)
		{
			ok_mc.y -=  20;
		}
		else
		{
			birak = false;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			ok_mc.y = 629.7;
		}
		if (ok_mc.hitTestObject(Abalon))
		{
			if (dogruCevap()==Abalon)
			{
				Abalon.gotoAndPlay(2);
				puan +=  10;
				puanT.text = puan.toString();
				Abalon.cevap = true;
				birak = false;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				ok_mc.y = 629.7;
				Bbalon.visible = true;
				B.visible = true;
				Bbalon.gotoAndStop(1);
				Cbalon.visible = true;
				C.visible = true;
				Cbalon.gotoAndStop(1);
				Dbalon.visible = true;
				D.visible = true;
				Dbalon.gotoAndStop(1);
				soru.soruUret();
				soruT.text = soru.soru;
				cevapYerlestir();
			}
			else
			{
				Abalon.gotoAndPlay(2);
				A.visible = false;
				birak = false;// bir defa patlamasını sağlıyor
				puan-=2;
				puanT.text=puan.toString();
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				//yayın tekrar hareketini sağlıyor;
				ok_mc.y = 629.7;//okun yaya geri gelmesini sağlıyor
			}
		}
		if (ok_mc.hitTestObject(Bbalon))
		{
			if (dogruCevap()==Bbalon)
			{
				Bbalon.gotoAndPlay(2);
				puan +=  10;
				puanT.text = puan.toString();
				Bbalon.cevap = true;
				birak = false;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				ok_mc.y = 629.7;
				Abalon.visible = true;
				A.visible = true;
				Abalon.gotoAndStop(1);
				Cbalon.visible = true;
				C.visible = true;
				Cbalon.gotoAndStop(1);
				Dbalon.visible = true;
				D.visible = true;
				Dbalon.gotoAndStop(1);
				soru.soruUret();
				soruT.text = soru.soru;
				cevapYerlestir();
			}
			else
			{
				Bbalon.gotoAndPlay(2);
				B.visible = false;
				puan-=2;
				puanT.text=puan.toString();
				birak = false;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				ok_mc.y = 629.7;
			}
		}
		if (ok_mc.hitTestObject(Cbalon))
		{
			if (dogruCevap()==Cbalon)
			{
				Cbalon.gotoAndPlay(2);
				puan +=  10;
				puanT.text = puan.toString();
				Cbalon.cevap = true;
				birak = false;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				ok_mc.y = 629.7;
				Bbalon.visible = true;
				B.visible = true;
				Bbalon.gotoAndStop(1);
				Abalon.visible = true;
				A.visible = true;
				Abalon.gotoAndStop(1);
				Dbalon.visible = true;
				D.visible = true;
				Dbalon.gotoAndStop(1);
				soru.soruUret();
				soruT.text = soru.soru;
				cevapYerlestir();
			}
			else
			{
				Cbalon.gotoAndPlay(2);
				C.visible = false;
				birak = false;
				puan-=2;
				puanT.text=puan.toString();
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				ok_mc.y = 629.7;
			}
		}
		if (ok_mc.hitTestObject(Dbalon))
		{
			if (dogruCevap()==Dbalon)
			{
				Dbalon.gotoAndPlay(2);
				puan +=  10;
				puanT.text = puan.toString();
				Dbalon.cevap = true;
				birak = false;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				ok_mc.y = 629.7;
				Bbalon.visible = true;
				B.visible = true;
				Bbalon.gotoAndStop(1);
				Cbalon.visible = true;
				C.visible = true;
				Cbalon.gotoAndStop(1);
				Abalon.visible = true;
				A.visible = true;
				Abalon.gotoAndStop(1);
				soru.soruUret();
				soruT.text = soru.soru;
				cevapYerlestir();
			}
			else
			{
				Dbalon.gotoAndPlay(2);
				D.visible = false;
				birak = false;
				puan-=2;
				puanT.text=puan.toString();
				stage.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
				ok_mc.y = 629.7;
			}
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
	var ds:String = a[dogruIndexNo];
	var cevaplar:Array = new Array(4);
	cevaplar[0] = soru.cevap;
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