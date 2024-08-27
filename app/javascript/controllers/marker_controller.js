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
        const bounds = this.element.getBoundingClientRect();

        if (this.canvasTarget.getContext) {
            const ctx = this.canvasTarget.getContext("2d");

            const img = new Image();

            img.addEventListener("load", () => {
                const h = img.height;
                const w = img.width;

                this.canvasTarget.width = w;
                this.canvasTarget.height = h;

                ctx.drawImage(img, 0, 0);

                let r = 3;

                ctx.beginPath()
                let ox = this.oxValue * w;
                let oy = this.oyValue * h;

                ctx.ellipse(ox, oy, r, r, 0, 0, 2 * Math.PI);
                ctx.fillStyle = "#00FF00";
                ctx.stroke();
                ctx.fill();

                ctx.beginPath()
                let ex = this.exValue * w;
                let ey = this.eyValue * h;

                ctx.ellipse(ex, ey, r, r, 0, 0, 2 * Math.PI);
                ctx.fillStyle = "#FF0000";
                ctx.stroke();
                ctx.fill();
            });

            img.src = this.srcValue;
        }
    }
}
