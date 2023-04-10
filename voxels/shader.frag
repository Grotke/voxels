#version 450

layout(location = 0) in vec4 fragColor;
layout(location = 1) in vec3 lightVector;
layout(location = 2) in vec3 eyeVector;
layout(location = 3 ) in vec3 normal;
layout(location = 4) in vec2 fragTexCoord;

layout(binding = 1) uniform sampler2D texSampler;

layout(location = 0) out vec4 outColor;

void main(){
	vec3 lightColor = {1.0, 1.0, 1.0};
	float shininess = 16.0;
	vec3 halfwayDir = normalize(lightVector + eyeVector);
	float spec = pow(max(dot(normal, halfwayDir), 0.0), shininess);
	vec3 norm = normalize(normal);
	float diff = max(dot(norm, lightVector), 0.0);
	vec3 diffuse = diff * lightColor;
	vec3 specular = lightColor * spec;
	vec3 ambient = {0.1, 0.1, 0.1};
	vec3 result = (ambient + diffuse + specular) * vec3(texture(texSampler, fragTexCoord));
	outColor = vec4(result, 1.0);
}