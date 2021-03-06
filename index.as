﻿fscommand("allowscale", "true");
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.text.TextField;
import fl.motion.Color;
import flash.display.FrameLabel;

/*global*/
var puan:int = 0;
var okAtildi:Boolean = false;//okbırakıldı anlamında
var yayBirakildi:Boolean = false;//yay bırakıldı anlamında
var sure:sureSay;//sure sınıfının kullanılacağı değişken
var soru:sor;//sor sınıfının kullanılacağı değişken
var beklet:Timer = new Timer(1000,1);//dönütü ekranda birsaniye bekletmek için kullanılıyor
/**
* Süre bitince Çalışacak fonksiyon 
* 
**/
function oyunBitti()
{
	tiklamaAlani.removeEventListener(MouseEvent.MOUSE_MOVE,kaydir);
	gotoAndStop(3);
	skorT.text = 'Tebrikler.\n 1 Dakika sürede ' + soru.soruSayisi + ' sorudan ' + puan.toString() + ' puan aldınız. ';
	//tiklamaAlani.removeEventListener(MouseEvent.CLICK,okAt);
	stage.removeEventListener(Event.ENTER_FRAME,calistir);
	var doldurYenidenBaslaZ:Timer = new Timer(50);
	doldurYenidenBaslaZ.addEventListener(TimerEvent.TIMER,doldurYenidenBasla);
	yenidenOyna.addEventListener(MouseEvent.CLICK,function(){doldurYenidenBaslaZ.start();});
	/**
	* Buton içeriğini dolduran ve sonunda tenımlı işlemi yapan fonksiyon 
	* 
	**/
	function doldurYenidenBasla(e:TimerEvent)
	{
		if (yenidenOyna.liquid.x < 0)
		{
			yenidenOyna.liquid.x +=  3;
		}
		else
		{
			doldurYenidenBaslaZ.stop();
			gotoAndStop(1);
		}
	}
	puan = 0;
}
/*kapat butonu*/
kapat.addEventListener(MouseEvent.CLICK,kapatsinmi);
function kapatsinmi(e:MouseEvent)
{
	kapat.gotoAndStop(2);
	if (currentFrame==2)
	{
		sure.sureDurdur();
	}
	// oyunun  oynandığı  karede ise süreyi  durdur ;
	kapat.evetButon.addEventListener(MouseEvent.MOUSE_DOWN,function (){fscommand("quit");});
	kapat.hayirButon.addEventListener(MouseEvent.MOUSE_DOWN,function (){kapat.gotoAndStop(1);if(currentFrame==2)sure.sureBaslat();});
}
/*yardım butonu*/
yardim.addEventListener(MouseEvent.CLICK,yardimPencere);
function yardimPencere(e:MouseEvent)
{
	yardim.gotoAndStop(2);
	if (currentFrame==2)
	{
		sure.sureDurdur();
	}
	// oyunun  oynandığı  karede ise süreyi  durdur ;
	yardim.tamamButon.addEventListener(MouseEvent.MOUSE_DOWN,function (){yardim.gotoAndStop(1);if(currentFrame==2)sure.sureBaslat();});
}
/*hakkında butonu*/
hakkinda.addEventListener(MouseEvent.CLICK,hakkindaPencere);
function hakkindaPencere(e:MouseEvent)
{
	hakkinda.gotoAndStop(2);
	if (currentFrame==2)
	{
		sure.sureDurdur();
	}
	// oyunun  oynandığı  karede ise süreyi  durdur ;
	hakkinda.tamamButon.addEventListener(MouseEvent.MOUSE_DOWN,function (){hakkinda.gotoAndStop(1);if(currentFrame==2)sure.sureBaslat();});
}
/////////////////////////////////////////////////;
/*kare 1*/
var doldurZ:Timer = new Timer(50);
doldurZ.addEventListener(TimerEvent.TIMER,doldur);
buton.addEventListener(MouseEvent.CLICK,function(){doldurZ.start();});
/**
* Buton içeriğini dolduran ve sonunda tenımlı işlemi yapan fonksiyon 
* 
**/
function doldur(e:TimerEvent)
{
	if (buton.liquid.x < 0)
	{
		buton.liquid.x +=  3;
	}
	else
	{
		doldurZ.stop();
		kare2();
	}
}
/*kare 2*/
function kare2()
{
	var seviye:int = seviyeBelirle.seviye;

	gotoAndStop(2);
	sure = new sureSay(1,0,oyunBitti,süre);// kronometre
	puanT.text = puan.toString();
	soru = new sor(seviye);//soru sınıfının Çağırılması
	soru.soruUret();
	puanver(true,true);
	soruT.text = soru.soru;
	cevapYerlestir();
	tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
	tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
	stage.addEventListener(Event.ENTER_FRAME,calistir);
}
/**
* oku Ekranda kaydırma işlemini yapan fonksiyon
* 
* @param mouse MouseEvent
* 
**/
function kaydir(mouse:MouseEvent)
{
	yay_mc.x = mouse.stageX;
	ok_mc.x = mouse.stageX;
}
/**
* Ok atıldığında yapılacak işlemler
* 
**/
function okAt(e:MouseEvent)
{
	okAtildi = true;
	yayBirakildi = true;
}
/**
* parametre olarak girilen textbox ı renklendirir
* 
* @param nesne:Object renklendirilecek nesne
* 
**/
function renklendir(nesne:TLFTextField,renk:int)
{

	var myformat:TextFormat = new TextFormat();
	//Bir textFormat tanımladım

	myformat.color = renk;
	//textFormat yazı  rengi kırmızı olacak

	nesne.setTextFormat(myformat,0,nesne.length);
}

function calistir(mouse:Event)
{
if (okAtildi)
{
	if (yayBirakildi)
	{
		yay_mc.gotoAndPlay(2);
		yayBirakildi = false;//yayın sürekli atılmasını ses çıkartmasını engellemek için
	}
	tiklamaAlani.removeEventListener(MouseEvent.MOUSE_MOVE,kaydir);
	tiklamaAlani.removeEventListener(MouseEvent.CLICK,okAt);
	if (ok_mc.y >= 0)
	{
		ok_mc.y -=  20;
	}
	else
	{
		okAtildi = false;
		tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
		tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
		ok_mc.y = 629.7;
	}

	if (ok_mc.hitTestObject(Abalon))
	{
		if ((dogruCevap() == Abalon))
		{
			Abalon.gotoAndPlay(2);
			donut.text = 'TEBRİKLER DOĞRU';
			renklendir(donut,0x00CC00);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanver(true);
			puanT.text = puan.toString();
			Abalon.cevap = true;
			okAtildi = false;//ok  atıldı  ama ok  ekrandan çıkmadığı  için burada tekrar false yapıp listenerları  ekliyoruz
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
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
			puanver(true,true);
			soruT.text = soru.soru;
			cevapYerlestir();
		}
		else
		{
			Abalon.gotoAndPlay(2);
			A.visible = false;
			okAtildi = false;// bir defa patlamasını sağlıyor
			puanver(false);
			donut.text = 'YANLIŞ TEKRAR DENE';
			renklendir(donut,0xCC0000);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanT.text = puan.toString();
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
			//yayın tekrar hareketini sağlıyor;
			ok_mc.y = 629.7;//okun yaya geri gelmesini sağlıyor
			//donut.text="";
		}
	}
	if (ok_mc.hitTestObject(Bbalon))
	{
		if ((dogruCevap() == Bbalon))
		{
			Bbalon.gotoAndPlay(2);
			puanver(true);
			donut.text = 'TEBRİKLER DOĞRU';
			renklendir(donut,0x00CC00);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanT.text = puan.toString();
			Bbalon.cevap = true;
			okAtildi = false;
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
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
			puanver(true,true);
			soruT.text = soru.soru;
			cevapYerlestir();
		}
		else
		{
			Bbalon.gotoAndPlay(2);
			B.visible = false;
			puanver(false);
			donut.text = 'YANLIŞ TEKRAR DENE';
			renklendir(donut,0xCC0000);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanT.text = puan.toString();
			okAtildi = false;
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
			ok_mc.y = 629.7;
		}
	}
	if (ok_mc.hitTestObject(Cbalon))
	{
		if ((dogruCevap() == Cbalon))
		{
			Cbalon.gotoAndPlay(2);
			puanver(true);
			donut.text = 'TEBRİKLER DOĞRU';
			renklendir(donut,0x00CC00);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanT.text = puan.toString();
			Cbalon.cevap = true;
			okAtildi = false;
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
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
			puanver(true,true);
			soruT.text = soru.soru;
			cevapYerlestir();
		}
		else
		{
			Cbalon.gotoAndPlay(2);
			C.visible = false;
			okAtildi = false;
			puanver(false);
			donut.text = 'YANLIŞ TEKRAR DENE';
			renklendir(donut,0xCC0000);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanT.text = puan.toString();
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
			ok_mc.y = 629.7;
		}
	}
	if (ok_mc.hitTestObject(Dbalon))
	{
		if ((dogruCevap() == Dbalon))
		{
			Dbalon.gotoAndPlay(2);
			puanver(true);
			donut.text = 'TEBRİKLER DOĞRU';
			renklendir(donut,0x00CC00);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanT.text = puan.toString();
			Dbalon.cevap = true;
			okAtildi = false;
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
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
			puanver(true,true);
			soruT.text = soru.soru;
			cevapYerlestir();
		}
		else
		{
			Dbalon.gotoAndPlay(2);
			D.visible = false;
			okAtildi = false;
			puanver(false);
			donut.text = 'YANLIŞ TEKRAR DENE';
			renklendir(donut,0xCC0000);
			beklet.start();
			beklet.addEventListener(TimerEvent.TIMER_COMPLETE,function(){donut.text="";});
			puanT.text = puan.toString();
			tiklamaAlani.addEventListener(MouseEvent.MOUSE_MOVE,kaydir);
			tiklamaAlani.addEventListener(MouseEvent.CLICK,okAt);
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
var a:Array;//şıkları  tutan değişken
// doğru şıkkı  seç
var dogruIndexNo:int;
function cevapYerlestir()
{
a = ['A','B','C','D'];
dogruIndexNo = soru.rasgele(0,3);
var ds:String = a[dogruIndexNo];//doğru şık
var cevaplar:Array = new Array(4);
cevaplar[0] = soru.cevap;
var i:int;
for (i = 1; i < 4; i++)
{//bu döngü oyunun donmasına sebep olabiliyor cevap aralığını -5,+5 den -10,+10 olarak değiştirdim 
	var rCevap:int = soru.rasgele(soru.cevap - 10,soru.cevap + 10);
	while (cevaplar.lastIndexOf(rCevap) >= 0)
	{
		rCevap = soru.rasgele(soru.cevap - 10,soru.cevap + 10);
	}
	cevaplar[i] = rCevap;
}
var gecici:int = cevaplar[dogruIndexNo];
cevaplar[dogruIndexNo] = soru.cevap;
cevaplar[0] = gecici;
for (i = 0; i < 4; i++)
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
 * doğru cevabın olduğu balonu  belirler.cevap yerleştirden sonra çalıştırılmalı
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
/**
* puanver fonksiyonu verilen cevabın verilme sırasına göre alınan puanı belirler
* 
* 
**/
var yanlisSayisi:int;
function puanver(cevap:Boolean,sifirla:Boolean=false)
{
if (sifirla)
{
	yanlisSayisi = 0;
	return;
}
if (cevap)
{
	// puanı ver 
	switch (yanlisSayisi)
	{
		case 0 :
			puan +=  10;
			break;
		case 1 :
			puan +=  7;
			break;
		case 2 :
			puan +=  3;
			break;
		case 3 :
			puan +=  0;
			break;
	}
}
else
{
	// yanlış cavap verildi puan ı azalt
	yanlisSayisi++;
}
}