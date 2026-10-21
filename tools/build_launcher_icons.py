from pathlib import Path
from PIL import Image, ImageDraw
root=Path(__file__).resolve().parent.parent
base=Image.new('RGBA',(1024,1024),(0,0,0,0)); d=ImageDraw.Draw(base)
d.rounded_rectangle((28,28,996,996),radius=210,fill='#00685F')
d.polygon([(210,355),(512,182),(814,355)],fill='white')
d.rounded_rectangle((226,383,798,424),radius=12,fill='white')
for x in [272,415,558,701]:d.rounded_rectangle((x,466,x+52,704),radius=12,fill='white')
d.rounded_rectangle((226,746,798,794),radius=12,fill='white')
for density,size in [('mdpi',48),('hdpi',72),('xhdpi',96),('xxhdpi',144),('xxxhdpi',192)]:
    base.resize((size,size),Image.Resampling.LANCZOS).save(root/f'android/app/src/main/res/mipmap-{density}/ic_launcher.png')
base.save(root/'windows/runner/resources/app_icon.ico',sizes=[(16,16),(32,32),(48,48),(64,64),(128,128),(256,256)])
(root/'assets/branding').mkdir(parents=True,exist_ok=True)
base.resize((256,256),Image.Resampling.LANCZOS).save(root/'assets/branding/simaha.png')
print('Launcher icons generated')
