import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["canvas"]
    static values = {
        src: String,
        ox: Number,
        oy: Number,
        ex: Number,
        ey: Number,
    }

    connect() {
        const dpr = Math.max(window.devicePixelRatio || 1, 1);

        if (this.canvasTarget.getContext) {
            const canvas = this.canvasTarget;
            const ctx = canvas.getContext("2d");

            const img = new Image();

            img.addEventListener("load", () => {
                const h = img.height;
                const w = img.width;

                canvas.width = w;
                canvas.height = h;
                canvas.setAttribute("style", `width: ${w/dpr}px; height: ${h/dpr}px;`);

                ctx.drawImage(img, 0, 0);

                let r = 3;
                let r2 = 20;

                ctx.lineWidth = 2;

                let ox = this.oxValue * w;
                let oy = this.oyValue * h;

                let ex = this.exValue * w;
                let ey = this.eyValue * h;

                ctx.beginPath()
                ctx.moveTo(ox, oy);
                ctx.lineTo(ex, ey);
                ctx.stroke()

                ctx.beginPath()
                ctx.ellipse(ox, oy, r2, r2, 0, 0, 2 * Math.PI);
                ctx.stroke()

                ctx.beginPath()
                ctx.ellipse(ex, ey, r2, r2, 0, 0, 2 * Math.PI);
                ctx.stroke()

                ctx.beginPath()
                ctx.ellipse(ox, oy, r, r, 0, 0, 2 * Math.PI);
                ctx.fillStyle = "#00FF00";
                ctx.stroke();
                ctx.fill();

                ctx.beginPath()
                ctx.ellipse(ex, ey, r, r, 0, 0, 2 * Math.PI);
                ctx.fillStyle = "#FF0000";
                ctx.stroke();
                ctx.fill();
            });

            img.src = this.srcValue;
        }
    }
}
