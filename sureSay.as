package 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class sureSay
	{
		private var timer:Timer = new Timer(1000);//süreyi  çalıştıran timer
		private var sn:Number;
		private var dk:Number;
		private var dakika:String;
		private var saniye:String;
		private var ileriGeri:String;
		private var bitti:Function;
		private var bsn:int;//bitiş saniyesi
		private var bdk:int;//bitiş dakikası
		private var sureObj:Object;//süre değişiminin yazılacağı TLFTextField
		public function sureSay(gdk:int,gsn:int,bitti:Function,gsureObj:Object,ileriGeri:String='-',bdk:int=0,bsn:int=0)
		{
			// constructor code
			this.sn = gsn;
			this.dk = gdk;
			this.ileriGeri = ileriGeri;
			this.bitti = bitti;
			this.bdk = bdk;
			this.bsn = bsn;
			this.timer.addEventListener(TimerEvent.TIMER,this.sayac);
			this.sureObj = gsureObj;
			this.sureBaslat();
		}
		/**
		* 
		* 
		* 
		**/
		public function sayac(t:TimerEvent)
		{
			if (this.sn < 10)
			{
				this.saniye = '0' + this.sn.toString();
			}
			else
			{
				this.saniye = this.sn.toString();
			}
			if ((dk < 10))
			{
				this.dakika = '0' + this.dk.toString();
			}
			else
			{
				this.dakika = this.dk.toString();
			}
			this.sureObj.text = dakika + ':' + saniye;
			if ((this.ileriGeri == '-'))
			{

				if (this.sn <= this.bsn && this.dk <= this.bdk)
				{
					this.complate();
				}
				if ((this.sn <= 0))
				{
					this.dk--;
					this.sn = 59;
				}
				this.sn--;
			}
			else
			{

				if (this.sn >= this.bsn && this.dk >= this.bdk)
				{
					this.complate();
				}
				if ((this.sn == 59))
				{
					this.dk++;
					this.sn = 00;
				}
				this.sn++;
			}

		}
		/**
		* süre sayarı başlatır
		* 
		**/
		public function sureBaslat()
		{

			this.timer.start();
		}
		/**
		* süre sayarı durdurur
		* 
		**/
		public function sureDurdur()
		{
			this.timer.stop();
		}
		/**
		* süre bitiminde çalışacak foksiyon
		* 
		**/
		private function complate()
		{
			this.timer.reset();
			this.timer.stop();
			this.bitti();
		}


	}

}