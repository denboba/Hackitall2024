from PIL import Image
import potrace
import numpy as np

def png_to_svg(png_path, svg_path):
    # Open the PNG image
    image = Image.open(png_path).convert('L')  # Convert to grayscale
    bw = image.point(lambda x: 0 if x < 128 else 255, '1')  # Convert to black and white

    # Convert the image to a numpy array
    bitmap = np.array(bw, dtype=np.uint8)

    # Create a potrace bitmap
    potrace_bitmap = potrace.Bitmap(bitmap)

    # Trace the bitmap to a path
    path = potrace_bitmap.trace()

    # Write the path to an SVG file
    with open(svg_path, 'w') as f:
        f.write('<svg xmlns="http://www.w3.org/2000/svg" version="1.1">\n')
        for curve in path:
            f.write('<path d="')
            for segment in curve:
                if segment.is_corner:
                    f.write(f'M{segment.start_point[0]},{segment.start_point[1]} ')
                    f.write(f'L{segment.c[1][0]},{segment.c[1][1]} ')
                else:
                    f.write(f'M{segment.start_point[0]},{segment.start_point[1]} ')
                    f.write(f'C{segment.c[0][0]},{segment.c[0][1]} ')
                    f.write(f'{segment.c[1][0]},{segment.c[1][1]} ')
                    f.write(f'{segment.end_point[0]},{segment.end_point[1]} ')
            f.write('Z" fill="black"/>\n')
        f.write('</svg>\n')

# Example usage
png_path = 'input.png'
svg_path = 'output.svg'
png_to_svg(png_path, svg_path)
