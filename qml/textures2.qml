import Qt3D.Core 2.0
import Qt3D.Render 2.0
import "Components"


/*
测试材质贴图
*/
Scene0 {
	Entity {
		id: root
		RenderSettings0 {}

		Entity {
			id: plane
            components: [geometry, material]

            // 面片数据（定义了顶点，颜色，纹理坐标，面片三角形）
			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					boundingVolumePositionAttribute: position
					Attribute {
						id: position
                        name: "position"
                        attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 0
						byteStride: 8 * 4
						buffer: vertexBuffer
					}
					Attribute {
                        name: "color"
                        attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 3 * 4
						byteStride: 8 * 4
						buffer: vertexBuffer
					}
					Attribute {
                        name: "texCoord"
                        attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 2
						count: 4
						byteOffset: 6 * 4
						byteStride: 8 * 4
						buffer: vertexBuffer
					}
					Attribute {
                        name: "triangle"
                        attributeType: Attribute.IndexAttribute
						vertexBaseType: Attribute.UnsignedShort
						vertexSize: 1
						count: 6
						buffer: Buffer {
							type: Buffer.IndexBuffer
							data: new Uint16Array([
								0, 1, 3,  // First Triangle
								1, 2, 3,  // Second Triangle
							])
						}
					}
				}

				Buffer {
					id: vertexBuffer
					type: Buffer.VertexBuffer
					data: new Float32Array([
						// Positions	  // Colors		// Texture Coords
						 0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   1.0, 1.0, // Top Right
						 0.5, -0.5, 0.0,   0.0, 1.0, 0.0,   1.0, 0.0, // Bottom Right
						-0.5, -0.5, 0.0,   0.0, 0.0, 1.0,   0.0, 0.0, // Bottom Left
						-0.5,  0.5, 0.0,   1.0, 1.0, 0.0,   0.0, 1.0, // Top Left
					])
				}
			}

            // 材质（如何渲染面片数据）
			Material {
				id: material
                // 图片做为参数传入
				parameters: Parameter {
					name: "ourTexture"
					value: Texture2D { // #TRYIT: change filtering mode
						generateMipMaps: true
						minificationFilter: Texture.Linear
						magnificationFilter: Texture.Linear
						wrapMode { // #TRYIT: change wrap mode
							x: WrapMode.Repeat
							y: WrapMode.Repeat
						}
						TextureImage {
							mipLevel: 0
							source: Resources.texture("container.jpg")
						}
					}
				}
                // 渲染
                effect: Effect {
                    techniques: Technique {
                        renderPasses: RenderPass {
                            renderStates: CullFace { mode: CullFace.NoCulling }
                            shaderProgram: ShaderProgram0 {
                                vertName: "texture"
                                fragName: "texture2"
                            }
                        }
                    }
                }

			}

		}
	}
}
