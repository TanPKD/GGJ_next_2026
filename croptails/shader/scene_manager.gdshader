shader_type canvas_item;

// 包围区域（在此是全屏）
uniform float progress: hint_range(0.0, 1.0);
uniform bool reverse = true;
// 切割的格子（竖， 横）
uniform vec2 num_of_tiles = vec2(16, 9);
<<<<<<< Updated upstream
uniform vec2 pixelsnum = vec2(16, 16);
=======
// 像素大小
uniform vec2 pixels = vec2(16, 16);
>>>>>>> Stashed changes

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 points_in_square = UV * num_of_tiles;
<<<<<<< Updated upstream
	vec2 pixelsposition = round(points_in_square * pixelsnum);
	vec2 frac = fract(pixelsposition / pixelsnum);
=======
	vec2 pixel = round(points_in_square * pixels);
	// vec2 frac = fract(points_in_square);
	vec2 frac = fract(pixel / pixels);
>>>>>>> Stashed changes
	vec2 dis = abs(frac - 0.5);
	float manhattan = dis.x + dis.y;
		
		if (reverse){
			if (manhattan + UV.x + UV.y <= progress * 3.0){
				discard;
			}
		}else{
			if (manhattan + UV.x + UV.y >= progress * 3.0){
				discard;
			}
		}
}