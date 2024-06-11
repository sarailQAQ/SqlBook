package main

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"os"
	"os/exec"
)

func Cors(context *gin.Context) {
	method := context.Request.Method
	// 必须，接受指定域的请求，可以使用*不加以限制，但不安全
	//context.Header("Access-Control-Allow-Origin", "*")
	context.Header("Access-Control-Allow-Origin", context.GetHeader("Origin"))
	//fmt.Println(context.GetHeader("Origin"))
	// 必须，设置服务器支持的所有跨域请求的方法
	context.Header("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE, OPTIONS")
	// 服务器支持的所有头信息字段，不限于浏览器在"预检"中请求的字段
	context.Header("Access-Control-Allow-Headers", "Content-Type, Content-Length, Token")
	// 可选，设置XMLHttpRequest的响应对象能拿到的额外字段
	context.Header("Access-Control-Expose-Headers", "Access-Control-Allow-Headers, Token")
	// 可选，是否允许后续请求携带认证信息Cookir，该值只能是true，不需要则不设置
	context.Header("Access-Control-Allow-Credentials", "true")
	// 放行所有OPTIONS方法
	if method == "OPTIONS" {
		context.AbortWithStatus(http.StatusNoContent)
		return
	}
	context.Next()
}



func main() {
	engine := gin.Default()
	
	engine.Use(Cors)

	engine.POST("/exec", func(c *gin.Context) {
		sql := c.PostForm("sql")
		if len(sql) == 0 {
			c.String(http.StatusOK, "empty sql")
			return
		}
		cmd := exec.Command("duckdb", "-s", sql, "test")
		cmd.Env = os.Environ()
		output, err := cmd.CombinedOutput()
		if err != nil {
			log.Println(err)
			log.Println(cmd.String())
			if len(output) > 0 {
				c.String(http.StatusOK, string(output))
			} else {
				c.String(http.StatusOK, err.Error())
			}

			return
		}
		c.String(http.StatusOK, string(output))
	})

	log.Println("start listening on port 8080")
	if err := engine.Run("0.0.0.0:8080"); err != nil {
		log.Println("server error:", err)
	}
}
