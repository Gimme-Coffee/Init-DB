import os
from PIL import Image


def classifyImage(path):
    im = Image.open(path)
    results = {
        'size': im.size,
        'mode': 'full',
    }

    try:
        while True:
            if im.tile:
                tile = im.tile[0]
                update_region = tile[1]
                update_region_dimensions = update_region[2:]

                if update_region_dimensions != im.size:
                    results['mode'] = 'partial'
                    break

            im.seek(im.tell() + 1)

    except EOFError:
        pass

    return results


def split(path):
    mode = classifyImage(path)['mode']

    im = Image.open(path)

    i = 0
    p = im.getpalette()
    last_frame = im.convert('RGBA')

    try:
        while True:
            print("saving %s (%s) frame %d, %s %s" %
                  (path, mode, i, im.size, im.tile))

            if not im.getpalette():
                im.putpalette(p)

            new_frame = Image.new('RGBA', im.size)

            if mode == 'partial':
                new_frame.paste(last_frame)

            new_frame.paste(im, (0, 0), im.convert('RGBA'))
            new_frame.save(
                './out/%s-%d.png' % (''.join(os.path.basename(path).split('.')[:-1]), i), 'PNG')

            i += 1

            last_frame = new_frame
            im.seek(im.tell() + 1)

    except EOFError:
        pass
