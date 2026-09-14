param(
    [string[]]$Names = @('small', 'close'),
    [string]$SourceDirectory = (Join-Path $PSScriptRoot '../resources/source'),
    [string]$OutputDirectory = (Join-Path $PSScriptRoot '../resources/icons')
)

Add-Type -AssemblyName System.Drawing

foreach ($name in $Names) {
    $source = [System.Drawing.Bitmap]::new((Join-Path $SourceDirectory "$name.png"))
    $result = [System.Drawing.Bitmap]::new($source.Width, $source.Height)
    try {
        $background = $source.GetPixel(0, 0).R
        $foreground = 255
        for ($y = 0; $y -lt $source.Height; $y++) {
            for ($x = 0; $x -lt $source.Width; $x++) {
                $foreground = [Math]::Min($foreground, $source.GetPixel($x, $y).R)
            }
        }
        # Recover edge coverage from the gray icon's original light background.
        for ($y = 0; $y -lt $source.Height; $y++) {
            for ($x = 0; $x -lt $source.Width; $x++) {
                $pixel = $source.GetPixel($x, $y)
                $alpha = [int][Math]::Round(255 * ($background - $pixel.R) / ($background - $foreground))
                $alpha = [Math]::Max(0, [Math]::Min(255, $alpha))
                $result.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, $foreground, $foreground, $foreground))
            }
        }
        $path = Join-Path $OutputDirectory "$name-transparent-28.png"
        $result.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
        Write-Output "$path : $($result.Width) x $($result.Height)"
    }
    finally {
        $source.Dispose()
        $result.Dispose()
    }
}
