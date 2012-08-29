package jbpm.vo;

import java.io.Serializable;

public class Position implements Serializable {
	private int x;
	private int y;
	private int width;
	private int height;

	public Position() {

	}

	public Position(int x, int y, int width, int height) {
		x = x;
		y = y;
		width = width;
		height = height;
	}

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}
}