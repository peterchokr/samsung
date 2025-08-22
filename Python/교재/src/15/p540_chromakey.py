import cv2

video = cv2.VideoCapture("trex.mp4") # 처리할 동영상을 읽는다.
image = cv2.imread("beach.jpg") # 배경 이미지를 읽는다.

# 동영상의 각 프레임을 읽어서 처리한다. 
while True:
    ret, frame = video.read()		# 비디오에서 하나의 프레임을 읽는다. 
    if not ret:					# ret이 False이면 동영상이 종료된 것이다. 
            break;

    frame = cv2.resize(frame, (640, 480))	# ①프레임의 크기를 640×480으로 한다. 
    image = cv2.resize(image, (640, 480))	# 배경 이미지의 크기를 640×480으로 한다. 

    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)	# ②BGR 형식을 HSV 형식으로 변환한다.
    mask = cv2.inRange(hsv, (50, 150, 0), (70, 255, 255))  # ③녹색만 골라서 마스크로 만든다. 
    cv2.copyTo(image, mask, frame)		# ④마스크를 이용하여 동영상과 이미지를 합성한다. 
    cv2.imshow("video", frame)			# ⑤이름이 ”video"인 윈도우에 프레임을 표시한다.
    
    if cv2.waitKey(50) == 27:			# ⑥50밀리초를 기다린다. 사용자가 ESC를 누르면 종료
            break
video.release()
cv2.destroyAllWindows()