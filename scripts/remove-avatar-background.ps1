param(
    [Parameter(Mandatory = $true)]
    [string]$SourcePath,
    [string]$OutputPath = (Join-Path $PSScriptRoot '../resources/icons/avatar-transparent-40.png')
)

Add-Type -AssemblyName System.Drawing
$source = [System.Drawing.Bitmap]::new($SourcePath)
$result = $source.Clone()
try {
    $queue = [System.Collections.Generic.Queue[System.Drawing.Point]]::new()
    $visited = [bool[]]::new($source.Width * $source.Height)
    for ($x = 0; $x -lt $source.Width; $x++) {
        $queue.Enqueue([System.Drawing.Point]::new($x, 0))
        $queue.Enqueue([System.Drawing.Point]::new($x, $source.Height - 1))
    }
    for ($y = 0; $y -lt $source.Height; $y++) {
        $queue.Enqueue([System.Drawing.Point]::new(0, $y))
        $queue.Enqueue([System.Drawing.Point]::new($source.Width - 1, $y))
    }
    # Only remove light pixels connected to the image border, preserving the avatar's white lines.
    while ($queue.Count -gt 0) {
        $p = $queue.Dequeue()
        if ($p.X -lt 0 -or $p.Y -lt 0 -or $p.X -ge $source.Width -or $p.Y -ge $source.Height) { continue }
        $index = $p.Y * $source.Width + $p.X
        if ($visited[$index]) { continue }
        $visited[$index] = $true
        $color = $source.GetPixel($p.X, $p.Y)
        if ($color.R -lt 244 -or $color.G -lt 244 -or $color.B -lt 244) { continue }
        $result.SetPixel($p.X, $p.Y, [System.Drawing.Color]::Transparent)
        $queue.Enqueue([System.Drawing.Point]::new($p.X - 1, $p.Y))
        $queue.Enqueue([System.Drawing.Point]::new($p.X + 1, $p.Y))
        $queue.Enqueue([System.Drawing.Point]::new($p.X, $p.Y - 1))
        $queue.Enqueue([System.Drawing.Point]::new($p.X, $p.Y + 1))
    }
    $result.Save([System.IO.Path]::GetFullPath($OutputPath), [System.Drawing.Imaging.ImageFormat]::Png)
    Write-Output "Size: $($result.Width)x$($result.Height); corner alpha: $($result.GetPixel(0,0).A)"
}
finally {
    $result.Dispose()
    $source.Dispose()
}
