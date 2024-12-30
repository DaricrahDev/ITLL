class Paths
{
	#if web
	public static var soundPrefix:String = 'mp3';
	#else
	public static var soundPrefix:String = 'ogg';
	#end

	public static function image(path:String)
	{
		return 'assets/images/$path.png';
	}

	public static function font(path:String)
	{
		return 'assets/fonts/$path';
	}

	public static function shader(path:String)
	{
		return 'assets/shaders/$path.glsl';
	}

	public static function levelJSON(path:String)
	{
		return 'assets/ogmo/$path.json';
	}

	public static function levelOGMO(path:String)
	{
		return 'assets/ogmo/$path.ogmo';
	}

	// true for music, false for sound effects.
	public static function sound(musicOrSound:Bool, path:String)
	{
		var soundDir = '';
		if (musicOrSound)
			soundDir = 'music';
		else
			soundDir = 'sounds';

		return 'assets/$soundDir/$path' + soundPrefix;
	}
}
