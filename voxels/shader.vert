#version 450

layout(set = 0, binding = 0) uniform UniformBufferObject {
	mat4 camera;
	mat4 scale;
	mat4 model;
	mat4 view;
	mat4 proj;
	mat4 baseTerrainTransform;
	int length;
	int width;
} ubo;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;

layout(location = 0) out vec4 fragColor;
layout(location = 1) out vec3 lightVector;
layout(location = 2) out vec3 eyeVector;

void main(){
	vec3 lightPosition = normalize(vec3(100000.0, -100000.0, 0));
	vec3 eyePosition = normalize(vec3(0.0, 10.0, 50.0)); // TODO: Pass in from code
	eyeVector = eyePosition - inPosition;
	lightVector = lightPosition - inPosition;
	int length = 100;
	int width = 100;
	int y = gl_InstanceIndex / (width * length);
	int newIndex = gl_InstanceIndex % (length * width);
	int z = newIndex / width;
	int x = newIndex % width;
	mat4 terrainTransform = ubo.baseTerrainTransform;
	terrainTransform[3][0] = x;
	terrainTransform[3][1] = y;
	terrainTransform[3][2] = z;
	gl_Position = ubo.proj * ubo.view * ubo.scale * ubo.camera * terrainTransform *vec4(inPosition, 1.0);
	if(gl_InstanceIndex % 2 == 0){
		fragColor = vec4(0.5, 0.5, 1.0, 1.0);
	} else {
		fragColor = vec4(inColor, 1.0);
	} // Change to dark grey if even
}